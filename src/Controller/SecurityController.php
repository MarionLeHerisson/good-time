<?php

namespace App\Controller;

use App\Entity\Address;
use App\Entity\Bar;
use App\Entity\BarPicture;
use App\Entity\Picture;
use App\Entity\User;
use App\Form\AddressFormType;
use App\Form\BarRegistrationFormType;
use App\Form\PictureFormType;
use App\Form\UserRegistrationFormType;
use App\Security\LoginFormAuthenticator;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;
use Symfony\Component\Security\Guard\GuardAuthenticatorHandler;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;

class SecurityController extends AbstractController
{
    /**
     * @Route("/login", name="login")
     * @param AuthenticationUtils $authenticationUtils
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function login(AuthenticationUtils $authenticationUtils)
    {
        // get the login error if there is one
        $error = $authenticationUtils->getLastAuthenticationError();

        // last username entered by the user
        $lastUsername = $authenticationUtils->getLastUsername();

        return $this->render('security/login.html.twig', [
            'last_username' => $lastUsername,
            'error'         => $error,
        ]);
    }

    /**
     * @Route("/logout", name="logout")
     */
    public function logout() {

    }

    /**
     * @Route("/inscription", name="app_register")
     * TODO 1 : si déjà connecté, rediriger vers /inscription-bar
     */
    public function userRegister(Request $request, UserPasswordEncoderInterface $passwordEncoder,
                             GuardAuthenticatorHandler $guardHandler, LoginFormAuthenticator $formAuthenticator)
    {
        $form_user = $this->createForm(UserRegistrationFormType::class);
        $form_user->handleRequest($request);

        if ($form_user->isSubmitted() && $form_user->isValid()) {

            /** @var User $user */
            $user = $form_user->getData();

            $user->setPassword($passwordEncoder->encodePassword(
                $user,
                $form_user['plainPassword']->getData()
            ));

            if (true === $form_user['isBarOwner']->getData()) {
                $user->setRoles([
                    'ROLE_BAR'
                ]);
            } else {
                $user->setRoles([
                    'ROLE_USER'
                ]);
            }

            $em = $this->getDoctrine()->getManager();
            $em->persist($user);
            $em->flush();

            $response = $guardHandler->authenticateUserAndHandleSuccess(
                $user,
                $request,
                $formAuthenticator,
                'main'
            );

            if (true === $form_user['isBarOwner']->getData()) {
                $response = $this->redirect('/inscription-bar');
            }

            return $response;
        }

        return $this->render('security/register.html.twig', [
            'userRegistrationForm' => $form_user->createView(),
        ]);
    }

    /**
     * @Route("/inscription-bar", name="app_bar_register")
     * TODO 1 : page inaccessible if not connected
     */
    public function barRegister(Request $request) {

        $form_address = $this->createForm(AddressFormType::class);
        $form_address->handleRequest($request);

        $form_bar = $this->createForm(BarRegistrationFormType::class);
        $form_bar->handleRequest($request);

        $form_picture = $this->createForm(PictureFormType::class);
        $form_picture->handleRequest($request);

        if ($form_bar->isSubmitted() && $form_bar->isValid()
            && $form_address->isSubmitted() && $form_address->isValid()) {

            /** @var Address $address */
            $address = $form_address->getData();

            /** @var Bar $bar */
            $bar = $form_bar->getData();

            /** @var BarPicture $barPicture */
            $barPicture = new BarPicture();

            /** @var Picture $picture */
            $picture = $form_picture->getData();

            // TODO 1 : handle (existing address && existing name)
            // TODO 1 : handle Google Map's autocomplete

            $path             = $picture->getPath();
            $allUploadedFiles = $request->files->all();
            $uploadedFile     = $allUploadedFiles['picture_form']['path'];
            $extension        = $uploadedFile->getClientOriginalExtension();    // TODO 1 : verify extension :grimace:
            $fileName         = md5(uniqid()).'.'.$extension;
            $destination      = 'media/bar_pictures/'.$fileName;    // TODO 2 : Who let the conf out ? Who who who who

            move_uploaded_file($path, $destination);
            $picture->setPath($fileName);

            $ownerId = $this->getUser()->getId();
            $bar->setOwnerId($ownerId);

            $em = $this->getDoctrine()->getManager();
            $em->persist($address);
            $em->persist($bar);
            $em->persist($picture);
            $em->flush();

            $barPicture->setBarId($bar->getId());
            $barPicture->setPictureId($picture->getId());

            $em->persist($barPicture);
            $em->flush();

            return $this->redirect('/bar');
        }

        return $this->render('security/bar-register.html.twig', [
            'barRegistrationForm' => $form_bar->createView(),
            'addressForm'         => $form_address->createView(),
            'pictureForm'         => $form_picture->createView(),
        ]);
    }
}
