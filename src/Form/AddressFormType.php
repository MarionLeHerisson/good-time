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
        // Todo : remove the damn comments :scream:
        $builder
            ->add('completeAddress', TextType::class, [
                'mapped' => false,
//                'constraints' => [
//                    new NotBlank([
//                        'message' => 'Votre bar doit bien se trouver quelque part !'
//                    ])
//                ]
            ])
            ->add('num', TextType::class, [
//                'disabled' => true
            ])
            ->add('street', TextType::class, [
//                'disabled' => true
            ])
            ->add('postCode', TextType::class, [
//                'disabled' => true
            ])
            ->add('city', TextType::class, [
//                'disabled' => true
            ])
            ->add('latitude', TextType::class, [
//                'disabled' => true
            ])
            ->add('longitude', TextType::class, [
//                'disabled' => true
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
