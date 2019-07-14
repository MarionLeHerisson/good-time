<?php

namespace App\Repository;

use App\Entity\Picture;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Symfony\Bridge\Doctrine\RegistryInterface;

class PictureRepository extends ServiceEntityRepository
{
    public function __construct(RegistryInterface $registry)
    {
        parent::__construct($registry, Picture::class);
    }

    // SELECT p.path
    // FROM picture p
    // LEFT JOIN bar_picture bp
    // ON bp.id = $barId
    // WHERE bp.is_main = 1;
    public function getMainPicture($barId): string
    {
        $query = $this->createQuery('p')
            ->select('path')
            ->leftJoin('bar_picture', 'bp', 'bp.id = :barId')
            ->setParameter('barId', $barId)
            ->andWhere('bp.is_main = 1')
            ->getQuery();
        dump($query);
        return $query->execute();
    }


    /*
    public function findOneBySomeField($value): ?User
    {
        return $this->createQueryBuilder('u')
            ->andWhere('u.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
