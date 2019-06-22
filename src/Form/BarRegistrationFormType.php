<?php

namespace App\Form;

use App\Entity\Bar;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\TelType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class BarRegistrationFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('name', TextType::class, [
                'attr' => ['class' => 'form-control'],
            ])
            ->add('addressId', TextType::class, [
                'attr' => ['class' => 'form-control'],
            ])
//            ->add('ownerId')
            ->add('phone', TelType::class, [
                'attr' => ['class' => 'form-control'],
            ])
            ->add('type', NumberType::class, [
                'attr' => ['class' => 'form-control'],
            ])
            ->add('schedule', TextareaType::class, [
                'attr' => ['hidden' => 'hidden',
                            'id'    => 'scheduleExport'],
            ])
//            ->add('createdAt')
//            ->add('isDeleted')
//            ->add('deletedAt')
        ;
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => Bar::class,
        ]);
    }
}
