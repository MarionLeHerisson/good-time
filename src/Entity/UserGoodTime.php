<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * UserGoodTime
 *
 * @ORM\Table(name="user_good_time", indexes={@ORM\Index(name="user_id", columns={"user_id"}), @ORM\Index(name="good_time_id", columns={"good_time_id"})})
 * @ORM\Entity
 */
class UserGoodTime
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
     * @ORM\Column(name="good_time_id", type="integer", nullable=false)
     */
    private $goodTimeId;

    /**
     * @var int
     *
     * @ORM\Column(name="user_id", type="integer", nullable=false)
     */
    private $userId;

    /**
     * @var string|null
     *
     * @ORM\Column(name="status", type="string", length=3, nullable=true)
     */
    private $status = '0';

    /**
     * @var int|null
     *
     * @ORM\Column(name="is_sam", type="smallint", nullable=true)
     */
    private $isSam = '0';

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

    public function getGoodTimeId(): ?int
    {
        return $this->goodTimeId;
    }

    public function setGoodTimeId(int $goodTimeId): self
    {
        $this->goodTimeId = $goodTimeId;

        return $this;
    }

    public function getUserId(): ?int
    {
        return $this->userId;
    }

    public function setUserId(int $userId): self
    {
        $this->userId = $userId;

        return $this;
    }

    public function getStatus(): ?string
    {
        return $this->status;
    }

    public function setStatus(?string $status): self
    {
        $this->status = $status;

        return $this;
    }

    public function getIsSam(): ?int
    {
        return $this->isSam;
    }

    public function setIsSam(?int $isSam): self
    {
        $this->isSam = $isSam;

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
