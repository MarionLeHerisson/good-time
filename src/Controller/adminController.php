<?php
/**
 * Created by PhpStorm.
 * User: Marion
 * Date: 16/05/2019
 * Time: 15:29
 */

namespace App\Controller;


use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

/**
 * @IsGranted("ROLE_ADMIN")
 */
class adminController extends AbstractController
{
    /**
     * @Route(path="/admin", name="admin_home")
     */
    public function homepageAction()
    {
        return $this->render('admin_home.html.twig', [

        ]);
    }
}