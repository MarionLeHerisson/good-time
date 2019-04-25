<?php

namespace App\DataFixtures;

use App\Entity\User;
use Doctrine\Common\Persistence\ObjectManager;

class UserFixture extends BaseFixture
{
    public function loadData(ObjectManager $manager)
    {
        $this->createMany(10, 'main_users', function($i) {
            $user = new User();
            $user->setEmail(sprintf($this->faker->email));
            $user->setName(sprintf($this->faker->firstName . ' ' . $this->faker->lastName));

            return $user;
        });

        $manager->flush();
    }
}