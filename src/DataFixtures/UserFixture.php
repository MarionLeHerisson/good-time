<?php

namespace App\DataFixtures;

use App\Entity\User;
use Doctrine\Common\Persistence\ObjectManager;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

class UserFixture extends BaseFixture
{
    private $passwordEncoder;

    public function __construct(UserPasswordEncoderInterface $passwordEncoder)
    {
        $this->passwordEncoder = $passwordEncoder;
    }

    public function loadData(ObjectManager $manager)
    {
        $this->createMany(10, 'main_users', function($i) {
            $user = new User();
            $user->setEmail(sprintf($this->faker->email));
            $user->setName(sprintf($this->faker->firstName . ' ' . $this->faker->lastName));
            $user->setPassword($this->passwordEncoder->encodePassword(
                $user,
                '123456'
            ));

            return $user;
        });

        $manager->flush();
    }
}
