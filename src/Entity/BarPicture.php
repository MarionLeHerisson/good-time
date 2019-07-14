<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * BarPicture
 *
 * @ORM\Table(name="bar_picture", indexes={@ORM\Index(name="picture_id", columns={"picture_id"}), @ORM\Index(name="bar_id", columns={"bar_id"})})
 * @ORM\Entity
 */
class BarPicture
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

    /**
     * @var int
     *
     * @ORM\Column(name="picture_id", type="integer", nullable=false)
     */
    private $pictureId;

    /**
     * @var int
     *
     * @ORM\Column(name="is_main", type="integer", nullable=false)
     */
    private $isMain = 0;

    /**
     * @var int|null
     *
     * @ORM\Column(name="is_deleted", type="integer", nullable=true)
     */
    private $isDeleted = '0';

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

    public function getPictureId(): ?int
    {
        return $this->pictureId;
    }

    public function setPictureId(int $pictureId): self
    {
        $this->pictureId = $pictureId;

        return $this;
    }

    public function getIsMain(): ?int
    {
        return $this->isMain;
    }

    public function setIsMain(int $isMain): self
    {
        $this->isMain = $isMain;

        return $this;
    }

    public function getIsDeleted(): ?int
    {
        return $this->isDeleted;
    }

    public function setIsDeleted(?int $isDeleted): self
    {
        $this->isDeleted = $isDeleted;

        return $this;
    }

}
