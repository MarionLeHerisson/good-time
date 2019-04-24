<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Schedule
 *
 * @ORM\Table(name="schedule", indexes={@ORM\Index(name="bar_id", columns={"bar_id"})})
 * @ORM\Entity
 */
class Schedule
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
     * @var string
     *
     * @ORM\Column(name="weekday", type="string", length=3, nullable=false)
     */
    private $weekday;

    /**
     * @var bool|null
     *
     * @ORM\Column(name="open", type="boolean", nullable=true, options={"default"="1"})
     */
    private $open = '1';

    /**
     * @var bool|null
     *
     * @ORM\Column(name="is_hh", type="boolean", nullable=true)
     */
    private $isHh = '0';

    /**
     * @var \DateTime
     *
     * @ORM\Column(name="hour", type="time", nullable=false)
     */
    private $hour;

    /**
     * @var string|null
     *
     * @ORM\Column(name="notes", type="text", length=65535, nullable=true)
     */
    private $notes;

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

    public function getWeekday(): ?string
    {
        return $this->weekday;
    }

    public function setWeekday(string $weekday): self
    {
        $this->weekday = $weekday;

        return $this;
    }

    public function getOpen(): ?bool
    {
        return $this->open;
    }

    public function setOpen(?bool $open): self
    {
        $this->open = $open;

        return $this;
    }

    public function getIsHh(): ?bool
    {
        return $this->isHh;
    }

    public function setIsHh(?bool $isHh): self
    {
        $this->isHh = $isHh;

        return $this;
    }

    public function getHour(): ?\DateTimeInterface
    {
        return $this->hour;
    }

    public function setHour(\DateTimeInterface $hour): self
    {
        $this->hour = $hour;

        return $this;
    }

    public function getNotes(): ?string
    {
        return $this->notes;
    }

    public function setNotes(?string $notes): self
    {
        $this->notes = $notes;

        return $this;
    }


}
