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
        // Todo 2 : remove the damn comments :scream:
        $builder
            ->add('completeAddress', TextType::class, [
                'attr' => ['class' => 'form-control'],
                'mapped' => false,
//                'constraints' => [
//                    new NotBlank([
//                        'message' => 'Votre bar doit bien se trouver quelque part !'
//                    ])
//                ]
            ])
            ->add('num', TextType::class, [
                'attr' => ['class' => 'form-control'],
//                'disabled' => true
            ])
            ->add('street', TextType::class, [
                'attr' => ['class' => 'form-control'],
//                'disabled' => true
            ])
            ->add('postCode', TextType::class, [
                'attr' => ['class' => 'form-control'],
//                'disabled' => true
            ])
            ->add('city', TextType::class, [
                'attr' => ['class' => 'form-control'],
//                'disabled' => true
            ])
            ->add('latitude', TextType::class, [
                'attr' => ['class' => 'form-control'],
//                'disabled' => true
            ])
            ->add('longitude', TextType::class, [
                'attr' => ['class' => 'form-control'],
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
