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
        return $this->render('homepage.html.twig', [

        ]);
    }

    /**
     * @Route(path="/inscription_bar", name="bar_registration")
     */
    public function barRegistration()
    {
        die("bar_registration");
    }

    /**
     * @Route(path="/inscription", name="registration")
     */
    public function userRegistration()
    {
        die("registration");
    }
}