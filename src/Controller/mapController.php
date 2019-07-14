<?php

namespace App\Controller;

use App\Entity\Address;
use App\Entity\Bar;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

class mapController extends AbstractController
{
    /**
     * @Route(path="/carte", name="map")
     */
    public function mapAction(EntityManagerInterface $em)
    {
        $barRepository     = $em->getRepository(Bar::class);
        $addressRepository = $em->getRepository(Address::class);

        $bars = $barRepository->findAll();

        foreach ($bars as $bar) {
            $bar->setCompleteAddress($addressRepository->findOneBy(['id' => $bar->getAddressId()]));
        }

        return $this->render('map.html.twig', [
            'bars' => $bars
        ]);
    }

    /**
     * @Route(path="/map/ajax", name="map_ajax")
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
        die;
    }

    private function handleAjaxRequest($em, $action, $parameter)
    {
        switch ($action) {
            case 'getAllBars':
                $this->getAllBars($em, $parameter);
                break;
        }
    }

    private function getAllBars($em, $parameter) {
        die('{
  "0": {
    "name": "Beucue",
    "phone": "0123456789",
    "lat": "48.8648",
    "lon": "2.37486",
    "cheaper_pint": "3.50",
    "address": "1 rue des Poissons 75007 Paris"
  },        
  "1": {
    "name": "Mitzva",
    "phone": "0123456789",
    "lat": "48.8693",
    "lon": "2.32434",
    "cheaper_pint": "4.00",
    "address": "435 rue lalala 75020 Paris"
  },        
  "2": {
    "name": "Celone",
    "phone": "0123456789",
    "lat": "48.8089",
    "lon": "2.3573",
    "cheaper_pint": "4.50",
    "address": "12 avenue Eugène Thomas 94270 Le Kremlin Bicêtre"
  },        
  "3": {
    "name": "Ackobama",
    "phone": "0123456789",
    "lat": "48.8579",
    "lon": "2.39982",
    "cheaper_pint": "5.00",
    "address": "57 rue de Bagnolet 75020 Paris"
  },        
  "4": {
    "name": "Akafrite",
    "phone": "0123456789",
    "lat": "48.8089",
    "lon": "2.3573",
    "cheaper_pint": "5.50",
    "address": "12 avenue Eugène Thomas 94270 Le Kremlin Bicêtre"
  }
}');
    }
}
