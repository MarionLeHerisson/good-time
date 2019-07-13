<?php

namespace App\Form;

use App\Entity\Address;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class AddressFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('completeAddress', TextType::class, [
                'attr' => [
                    'class' => 'form-control',
                    'id'    => 'autocomplete',
                ],
                'mapped' => false,
            ])
            ->add('num', HiddenType::class, [
                'attr' => [
                    'class' => 'form-control',
                    'id'    => 'street-number',
                ],
            ])
            ->add('street', HiddenType::class, [
                'attr' => [
                    'class' => 'form-control',
                    'id'    => 'route',
                ],
            ])
            ->add('postCode', HiddenType::class, [
                'attr' => [
                    'class' => 'form-control',
                    'id'    => 'postal_code',
                ],
            ])
            ->add('city', HiddenType::class, [
                'attr' => [
                    'class' => 'form-control',
                    'id'    => 'locality',
                ],
            ])
            ->add('latitude', HiddenType::class, [
                'attr' => [
                    'class' => 'form-control',
                    'id'    => 'latitude',
                ],
            ])
            ->add('longitude', HiddenType::class, [
                'attr' => [
                    'class' => 'form-control',
                    'id'    => 'longitude',
                ],
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => Address::class,
        ]);
    }
}
