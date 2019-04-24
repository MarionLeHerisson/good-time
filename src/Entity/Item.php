<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Item
 *
 * @ORM\Table(name="item")
 * @ORM\Entity
 */
class Item
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
     * @ORM\Column(name="name", type="string", length=100, nullable=false)
     */
    private $name;

    /**
     * @var string|null
     *
     * @ORM\Column(name="description", type="text", length=65535, nullable=true)
     */
    private $description;

    /**
     * @var bool|null
     *
     * @ORM\Column(name="is_food", type="boolean", nullable=true)
     */
    private $isFood = '0';

    /**
     * @var bool|null
     *
     * @ORM\Column(name="contains_alcohol", type="boolean", nullable=true)
     */
    private $containsAlcohol = '0';

    /**
     * @var bool|null
     *
     * @ORM\Column(name="contains_allergen", type="boolean", nullable=true)
     */
    private $containsAllergen = '0';

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(?string $description): self
    {
        $this->description = $description;

        return $this;
    }

    public function getIsFood(): ?bool
    {
        return $this->isFood;
    }

    public function setIsFood(?bool $isFood): self
    {
        $this->isFood = $isFood;

        return $this;
    }

    public function getContainsAlcohol(): ?bool
    {
        return $this->containsAlcohol;
    }

    public function setContainsAlcohol(?bool $containsAlcohol): self
    {
        $this->containsAlcohol = $containsAlcohol;

        return $this;
    }

    public function getContainsAllergen(): ?bool
    {
        return $this->containsAllergen;
    }

    public function setContainsAllergen(?bool $containsAllergen): self
    {
        $this->containsAllergen = $containsAllergen;

        return $this;
    }


}
