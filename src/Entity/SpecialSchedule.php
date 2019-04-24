<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * SpecialSchedule
 *
 * @ORM\Table(name="special_schedule", indexes={@ORM\Index(name="bar_id", columns={"bar_id"})})
 * @ORM\Entity
 */
class SpecialSchedule
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
     * @var \DateTime
     *
     * @ORM\Column(name="begin_date", type="datetime", nullable=false)
     */
    private $beginDate;

    /**
     * @var \DateTime
     *
     * @ORM\Column(name="end_date", type="datetime", nullable=false)
     */
    private $endDate;

    /**
     * @var \DateTime|null
     *
     * @ORM\Column(name="new_opening_hour", type="time", nullable=true)
     */
    private $newOpeningHour;

    /**
     * @var \DateTime|null
     *
     * @ORM\Column(name="new_closing_hour", type="time", nullable=true)
     */
    private $newClosingHour;

    /**
     * @var bool|null
     *
     * @ORM\Column(name="is_just_closed", type="boolean", nullable=true)
     */
    private $isJustClosed;

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

    public function getBeginDate(): ?\DateTimeInterface
    {
        return $this->beginDate;
    }

    public function setBeginDate(\DateTimeInterface $beginDate): self
    {
        $this->beginDate = $beginDate;

        return $this;
    }

    public function getEndDate(): ?\DateTimeInterface
    {
        return $this->endDate;
    }

    public function setEndDate(\DateTimeInterface $endDate): self
    {
        $this->endDate = $endDate;

        return $this;
    }

    public function getNewOpeningHour(): ?\DateTimeInterface
    {
        return $this->newOpeningHour;
    }

    public function setNewOpeningHour(?\DateTimeInterface $newOpeningHour): self
    {
        $this->newOpeningHour = $newOpeningHour;

        return $this;
    }

    public function getNewClosingHour(): ?\DateTimeInterface
    {
        return $this->newClosingHour;
    }

    public function setNewClosingHour(?\DateTimeInterface $newClosingHour): self
    {
        $this->newClosingHour = $newClosingHour;

        return $this;
    }

    public function getIsJustClosed(): ?bool
    {
        return $this->isJustClosed;
    }

    public function setIsJustClosed(?bool $isJustClosed): self
    {
        $this->isJustClosed = $isJustClosed;

        return $this;
    }


}
