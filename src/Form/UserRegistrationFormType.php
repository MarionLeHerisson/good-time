<?php

namespace App\Form;

use App\Entity\User;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\IsTrue;
use Symfony\Component\Validator\Constraints\Length;
use Symfony\Component\Validator\Constraints\NotBlank;

class UserRegistrationFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('email', EmailType::class, [
                'attr' => ['class' => 'form-control'],
            ])
            // don't use password: avoid EVER setting that on a
            // field that might be persisted
            ->add('plainPassword', PasswordType::class, [
                'attr' => ['class' => 'form-control'],
                'mapped' => false,
                'constraints' => [
                    new NotBlank([
                        'message' => 'Veuillez entrer un mot de passe.'
                    ]),
                    new Length([
                        'min' => 5,
                        'minMessage' => 'Votre mot de passe doit faire au moins 5 caractères.'
                    ])
                ]
            ])
            // Todo : link to CGU
            ->add('agreeTerms', CheckboxType::class, [
                'attr' => ['class' => 'form-control'],
                'mapped' => false,
                'label' => 'J\'accèpte avec joie les conditions générales d\'utilisation !',
                'constraints' => [
                    new IsTrue([
                        'message' => 'Vous devez accepter nos Conditions Générales d\'Utilisation.'
                    ])
                ]
            ])
            ->add('isBarOwner', CheckboxType::class, [
                'attr' => ['class' => 'form-control'],
                'mapped' => false,
                'label'  => 'Je suis propriétaire d\' un bar !',
                'required' => false
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => User::class,
        ]);
    }
}
