<?php
/**
 * Created by PhpStorm.
 * User: Marion
 * Date: 16/05/2019
 * Time: 15:34
 */

namespace App\Controller;

use App\Entity\Bar;
use App\Repository\PictureRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

/**
 * @IsGranted("ROLE_BAR")
 */
class barController extends AbstractController
{
    // Todo 2 : handle multiple bars ownership

    /**
     * @Route(path="/bar", name="bar_home")
     */
    public function homepageAction(EntityManagerInterface $em, PictureRepository $pictureRepository)
    {
        $ownerId = $this->getUser()->getId();

        $barRepository = $em->getRepository(Bar::class);
        $bar = $barRepository->findOneBy(['ownerId' => $ownerId]);

        if(!$bar) {
            return $this->render('/bar/not-registered-yet.html.twig');
        }

        $reservations = $this->getReservations();
        $mainPicture  = $this->getMainPicture();

        return $this->render('bar.html.twig', [
            'bar'                  => $bar,
            'hasNewReservations'   => "true", // TODO 1
            'isReservationsActive' => " active", // TODO 1
            'reservations'         => $reservations,
            'mainPicture'          => $mainPicture,
        ]);
    }

    // FIXTURES FUNCTIONS // TODO 1 : dynamic
    public function getMainPicture()
    {
        // SELECT p.path
        // FROM picture p
        // LEFT JOIN bar_picture bp
        // ON bp.picture_id = p.id
        // WHERE bp.bar_id = :barId
        // AND bp.is_main = 1;
//        $query = $em
//            ->createQuery('SELECT p.path FROM picture p LEFT JOIN bar_picture bp ON bp.picture_id = p.id WHERE bp.bar_id = :barId AND bp.is_main = 1;')
//            ->setParameter('barId', $bar->getId())
//        ;

        return '03821961a61c7747c73284f01d260323.jpg';
    }

    public function getReservations() {
        return [
            'waiting' => [
                [
                    'name' => 'John Doe',
                    'phone' => '0123456789',
                    'email' => 'john.doe@mail.fr',
                    'nb_persons' => 20,
                    'date' => '1565632800'
                ],
                [
                    'name' => 'Karen Doe',
                    'phone' => '0123456789',
                    'email' => 'karen.doe@mail.fr',
                    'nb_persons' => 12,
                    'date' => '1565632800'
                ],
                [
                    'name' => 'Lauren Doe',
                    'phone' => '0123456789',
                    'email' => 'lauren.doe@mail.fr',
                    'nb_persons' => 3,
                    'date' => '1565632800'
                ],
            ],
            'accepted' => [
                [
                    'name' => 'Morty Doe',
                    'phone' => '0123456789',
                    'email' => 'morty.doe@mail.fr',
                    'nb_persons' => 9,
                    'date' => '1565632800'
                ],
                [
                    'name' => 'Nathalia Doe',
                    'phone' => '0123456789',
                    'email' => 'nat.doe@mail.fr',
                    'nb_persons' => 8,
                    'date' => '1565632800'
                ],
                [
                    'name' => 'Oliver Doe',
                    'phone' => '0123456789',
                    'email' => 'oliver.doe@mail.fr',
                    'nb_persons' => 28,
                    'date' => '1565632800'
                ],
            ],
            'denied' => [
                [
                    'name' => 'Patrick Doe',
                    'phone' => '0123456789',
                    'email' => 'pat.doe@mail.fr',
                    'nb_persons' => 200,
                    'date' => '1565632800'
                ],
                [
                    'name' => 'Qi Doe',
                    'phone' => '0123456789',
                    'email' => 'qi.doe@mail.fr',
                    'nb_persons' => 45,
                    'date' => '1565632800'
                ],
                [
                    'name' => 'Rick Doe',
                    'phone' => '0123456789',
                    'email' => 'rick.doe@mail.fr',
                    'nb_persons' => 7,
                    'date' => '1565632800'
                ],
            ],
        ];
    }
}
