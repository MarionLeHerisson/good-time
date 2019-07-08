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
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
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
    public function homepageAction(EntityManagerInterface $em)
    {
        $ownerId = $this->getUser()->getId();

        $barRepository = $em->getRepository(Bar::class);
        $bar = $barRepository->findOneBy(['ownerId' => $ownerId]);

        if (!$bar) {
            return $this->render('/bar/not-registered-yet.html.twig');
        }

        $reservations = $this->getReservations();
        $mainPicture = $this->getMainPicture();
        $products = $this->getProducts();
        $allCategories = $this->getAllCategories();

        return $this->render('bar.html.twig', [
            'bar' => $bar,
            'hasNewReservations' => "true", // TODO 1
            'isReservationsActive' => " active", // TODO 1
            'reservations' => $reservations,
            'mainPicture' => $mainPicture,
            'products' => $products,
            'allCategories' => $allCategories,
        ]);
    }

    /**
     * @Route(path="/bar/ajax", name="bar_ajax")
     */
    public function ajaxAction(Request $request, EntityManagerInterface $em)
    {
        if ($request->isXmlHttpRequest()) {

            $data = $request->request->all();
            $this->handleAjaxRequest($em, $data['action'], $data['parameter']);
        }
        else {
            return new JsonResponse('Une erreur est survenue');
        }
    }

    private function handleAjaxRequest($em, $action, $parameter) {

        switch ($action) {
            case 'applyDiscount' :
                $this->applyDiscount($em, $parameter);
                break;
            case 'createDiscount' :
                $this->createDiscount($em, $parameter);
                break;
            case 'editItem' :
                $this->editItem($em, $parameter);
                break;
            case 'deleteItem' :
                $this->deleteItem($em, $parameter);
                break;
            case 'exportSchedule' :
                $this->exportSchedule($em, $parameter);
                break;
            case 'saveNewItem' :
                $this->saveNewItem($em, $parameter);
                break;
        }
    }

    private function applyDiscount($em, $parameter) {
        die('Réduction appliquée : ' . $parameter['new_price'] . ' sur le produit ' . $parameter['item_id']);
    }

    private function createDiscount($em, $parameter) {
        die('Réduction appliquée : ' . $parameter['new_price'] . ' sur les produits de type ' . $parameter['category']);
    }

    private function deleteItem($em, $parameter) {
        die('Element supprimé : ' . $parameter['item_id']);
    }

    private function editItem($em, $parameter) {
        die('Nouveau prix enregistré' . print_r($parameter));
    }

    private function exportSchedule($em, $parameter) {

        $ownerId = $this->getUser()->getId();

        $barRepository = $em->getRepository(Bar::class);
        $bar = $barRepository->findOneBy(['ownerId' => $ownerId]);

        $bar->setSchedule($parameter);

        $em->persist($bar);
        $em->flush();

        die('Vos nouveaux horaires ont bien été enregistrés !');
    }

    private function saveNewItem($em, $parameter) {
        die('Nouvel item enregistrée : ' . print_r($parameter));
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

    public function getProducts() {
        return [
            'cocktails' => [
                [
                    'id'       => 874,
                    'name'     => 'Mojito',
                    'price'    => '6,50 €',
                    'hh_price' => '5,00 €',
                    'discount' => '4,00 €',
                ],
                [
                    'id'       => 844,
                    'name'     => 'Cuba Libre',
                    'price'    => '6,50 €',
                    'hh_price' => '5,00 €',
                    'discount' => '',
                ],
                [
                    'id'       => 13,
                    'name'     => 'Caipirinha',
                    'price'    => '6,50 €',
                    'hh_price' => '5,00 €',
                    'discount' => '',
                ],
            ],
            'bières' => [
                [
                    'id'       => 22,
                    'name'     => '1664',
                    'price'    => '5,50 €',
                    'hh_price' => '4,00 €',
                    'discount' => '',
                ],
                [
                    'id'       => 740,
                    'name'     => 'Guinness',
                    'price'    => '6,50 €',
                    'hh_price' => '5,00 €',
                    'discount' => '',
                ],
            ],
            'tapas' => [
                [
                    'id'       => 4,
                    'name'     => 'planche de charcuterie',
                    'price'    => '10,50 €',
                    'hh_price' => '',
                    'discount' => '',
                ],
                [
                    'id'       => 653,
                    'name'     => 'Planche de fromages',
                    'price'    => '8,50 €',
                    'hh_price' => '',
                    'discount' => '',
                ],
                [
                    'id'       => 99,
                    'name'     => 'planche mixte',
                    'price'    => '15,50 €',
                    'hh_price' => '',
                    'discount' => '',
                ],
            ],
            'plats' => [
                [
                    'id'       => 150,
                    'name'     => 'burger',
                    'price'    => '13,50 €',
                    'hh_price' => '',
                    'discount' => '',
                ],
                [
                    'id'       => 998,
                    'name'     => 'fish & chips',
                    'price'    => '9,50 €',
                    'hh_price' => '',
                    'discount' => '7,00 €',
                ],
            ]
        ];
    }

    public function getAllCategories() {
        return [
            'Bières',
            'Boissons chaudes',
            'Boissons sans alcool',
            'Cocktails',
            'Cocktails sans alcool',
            'Entrées',
            'Plats',
            'Pressions',
            'Spiritueux',
            'Tapas',
            'Vins',
            'Vins blancs',
            'Vins rosés',
            'Vins rouges',
        ];
    }
}
