<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * User
 *
 * @ORM\Table(name="user", indexes={@ORM\Index(name="picture", columns={"picture"}), @ORM\Index(name="address_id", columns={"address_id"}), @ORM\Index(name="favorite_item", columns={"favorite_item"})})
 * @ORM\Entity
 */
class User
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
     * @var string
     *
     * @ORM\Column(name="email", type="string", length=255, nullable=false)
     */
    private $email;

    /**
     * @var string
     *
     * @ORM\Column(name="password", type="string", length=50, nullable=false)
     */
    private $password;

    /**
     * @var string|null
     *
     * @ORM\Column(name="name", type="string", length=255, nullable=true)
     */
    private $name;

    /**
     * @var int|null
     *
     * @ORM\Column(name="address_id", type="integer", nullable=true)
     */
    private $addressId;

    /**
     * @var string|null
     *
     * @ORM\Column(name="phone", type="string", length=10, nullable=true)
     */
    private $phone;

    /**
     * @var int|null
     *
     * @ORM\Column(name="picture", type="integer", nullable=true)
     */
    private $picture;

    /**
     * @var string|null
     *
     * @ORM\Column(name="token", type="string", length=255, nullable=true)
     */
    private $token;

    /**
     * @var int|null
     *
     * @ORM\Column(name="favorite_item", type="integer", nullable=true)
     */
    private $favoriteItem;

    /**
     * @var float|null
     *
     * @ORM\Column(name="max_price", type="float", precision=10, scale=0, nullable=true)
     */
    private $maxPrice;

    /**
     * @var int|null
     *
     * @ORM\Column(name="favorite_transportation", type="smallint", nullable=true)
     */
    private $favoriteTransportation;

    /**
     * @var \DateTime|null
     *
     * @ORM\Column(name="created_at", type="datetime", nullable=true, options={"default"="CURRENT_TIMESTAMP"})
     */
    private $createdAt = 'CURRENT_TIMESTAMP';

    /**
     * @var int|null
     *
     * @ORM\Column(name="is_deleted", type="smallint", nullable=true)
     */
    private $isDeleted = '0';

    /**
     * @var \DateTime|null
     *
     * @ORM\Column(name="deleted_at", type="datetime", nullable=true)
     */
    private $deletedAt;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getEmail(): ?string
    {
        return $this->email;
    }

    public function setEmail(string $email): self
    {
        $this->email = $email;

        return $this;
    }

    public function getPassword(): ?string
    {
        return $this->password;
    }

    public function setPassword(string $password): self
    {
        $this->password = $password;

        return $this;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(?string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function getAddressId(): ?int
    {
        return $this->addressId;
    }

    public function setAddressId(?int $addressId): self
    {
        $this->addressId = $addressId;

        return $this;
    }

    public function getPhone(): ?string
    {
        return $this->phone;
    }

    public function setPhone(?string $phone): self
    {
        $this->phone = $phone;

        return $this;
    }

    public function getPicture(): ?int
    {
        return $this->picture;
    }

    public function setPicture(?int $picture): self
    {
        $this->picture = $picture;

        return $this;
    }

    public function getToken(): ?string
    {
        return $this->token;
    }

    public function setToken(?string $token): self
    {
        $this->token = $token;

        return $this;
    }

    public function getFavoriteItem(): ?int
    {
        return $this->favoriteItem;
    }

    public function setFavoriteItem(?int $favoriteItem): self
    {
        $this->favoriteItem = $favoriteItem;

        return $this;
    }

    public function getMaxPrice(): ?float
    {
        return $this->maxPrice;
    }

    public function setMaxPrice(?float $maxPrice): self
    {
        $this->maxPrice = $maxPrice;

        return $this;
    }

    public function getFavoriteTransportation(): ?int
    {
        return $this->favoriteTransportation;
    }

    public function setFavoriteTransportation(?int $favoriteTransportation): self
    {
        $this->favoriteTransportation = $favoriteTransportation;

        return $this;
    }

    public function getCreatedAt(): ?\DateTimeInterface
    {
        return $this->createdAt;
    }

    public function setCreatedAt(?\DateTimeInterface $createdAt): self
    {
        $this->createdAt = $createdAt;

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

    public function getDeletedAt(): ?\DateTimeInterface
    {
        return $this->deletedAt;
    }

    public function setDeletedAt(?\DateTimeInterface $deletedAt): self
    {
        $this->deletedAt = $deletedAt;

        return $this;
    }


}
