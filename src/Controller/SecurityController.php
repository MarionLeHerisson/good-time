<?php

namespace App\Controller;

use App\Entity\Address;
use App\Entity\Bar;
use App\Entity\User;
use App\Form\AddressFormType;
use App\Form\BarRegistrationFormType;
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
     * todo : si déjà connecté, rediriger vers /inscription-bar
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
     * todo : page inaccessible if not connected
     */
    public function barRegister(Request $request) {

        $form_bar = $this->createForm(BarRegistrationFormType::class);
        $form_bar->handleRequest($request);

        $form_address = $this->createForm(AddressFormType::class);
        $form_address->handleRequest($request);

        if ($form_bar->isSubmitted() && $form_bar->isValid()
            && $form_address->isSubmitted() && $form_address->isValid()) {

            /** @var Address $address */
            $address = $form_address->getData();

            // TODO : handle (existing address && existing name)
            // TODO : handle Google Map's autocomplete

            /** @var Bar $bar */
            $bar = $form_bar->getData();

            $ownerId = $this->getUser()->getId();
            $bar->setOwnerId($ownerId);

            $em = $this->getDoctrine()->getManager();
            $em->persist($address);
            $em->persist($bar);
            $em->flush();

            return $this->redirect('/bar');
        }

        return $this->render('security/bar-register.html.twig', [
            'barRegistrationForm' => $form_bar->createView(),
            'addressForm'         => $form_address->createView(),
        ]);
    }
}
