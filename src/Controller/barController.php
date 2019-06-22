<?php
/**
 * Created by PhpStorm.
 * User: Marion
 * Date: 16/05/2019
 * Time: 15:34
 */

namespace App\Controller;

use App\Entity\Bar;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

/**
 * @IsGranted("ROLE_BAR")
 */
class barController extends AbstractController
{
    // Todo : handle multiple bars ownership

    /**
     * @Route(path="/bar", name="bar_home")
     */
    public function homepageAction(EntityManagerInterface $em)
    {
        $ownerId = $this->getUser()->getId();

        $repository = $em->getRepository(Bar::class);
        $bar = $repository->findOneBy(['ownerId' => $ownerId]);

        if(!$bar) {
            return $this->render('/bar/not-registered-yet.html.twig');
        }

        $reservations = [       // TODO : dynamic
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


        return $this->render('bar.html.twig', [
            'bar'                  => $bar,
            'hasNewReservations'   => "true", // TODO
            'isReservationsActive' => " active", // TODO
            'reservations'         => $reservations,
        ]);
    }
}
