<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Menu
 *
 * @ORM\Table(name="menu", indexes={@ORM\Index(name="bar_id", columns={"bar_id"})})
 * @ORM\Entity
 */
class Menu
{
    /**
     * @var int
     *
     * @ORM\Column(name="id", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="IDENTITY")
     */
    private $id;

    /**
     * @var int
     *
     * @ORM\Column(name="bar_id", type="integer", nullable=false)
     */
    private $barId;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getBarId(): ?int
    {
        return $this->barId;
    }

    public function setBarId(int $barId): self
    {
        $this->barId = $barId;

        return $this;
    }


}
