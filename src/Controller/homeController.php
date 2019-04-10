<?php
/**
 * Created by PhpStorm.
 * User: Marion
 * Date: 09/04/2019
 * Time: 12:38
 */

namespace App\Controller;


use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;

class homeController extends AbstractController
{
    /**
     * @Route(path="/", name="homepage")
     */
    public function homepageAction()
    {
        return $this->render('jumbotron.html.twig', [

        ]);
    }
}