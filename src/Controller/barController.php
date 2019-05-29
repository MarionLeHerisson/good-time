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
        // Todo : handle bar owner without any bar

        $ownerId = $this->getUser()->getId();

        $repository = $em->getRepository(Bar::class);
        $bar = $repository->findOneBy(['ownerId' => $ownerId]);

        if(!$bar) {
            $bar->setName('Il semblerait que vous n\'ayez pas encore enregistré votre bar. Nous vous invitons à '.
                'le faire <a href="/inscription-bar">ici</a>.');
        }

        return $this->render('bar.html.twig', [
            'bar' => $bar
        ]);
    }
}