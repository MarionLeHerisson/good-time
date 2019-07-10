<?php

namespace App\Form;

use App\Entity\Address;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\NotBlank;

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
            ->add('num', TextType::class, [
                'attr' => [
                    'class' => 'form-control',
                    'id'    => 'street-number',
                ],
                'disabled' => true,
            ])
            ->add('street', TextType::class, [
                'attr' => [
                    'class' => 'form-control',
                    'id'    => 'route',
                ],
                'disabled' => true,
            ])
            ->add('postCode', TextType::class, [
                'attr' => [
                    'class' => 'form-control',
                    'id'    => 'postal_code',
                ],
                'disabled' => true,
            ])
            ->add('city', TextType::class, [
                'attr' => [
                    'class' => 'form-control',
                    'id'    => 'locality',
                ],
                'disabled' => true,
            ])
            ->add('latitude', TextType::class, [
                'attr' => [
                    'class' => 'form-control',
                    'id'    => 'latitude',
                ],
                'disabled' => true,
            ])
            ->add('longitude', TextType::class, [
                'attr' => [
                    'class' => 'form-control',
                    'id'    => 'longitude',
                ],
                'disabled' => true,
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
