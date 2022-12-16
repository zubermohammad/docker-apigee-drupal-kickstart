<?php

namespace Drupal\bmcoder\Form;

use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;

/**
 *
 */
class ExampleForm extends Formbase {

  /**
   * {@inheritdoc}
   */
  public function getFormId() {
    return 'bmcoder_form';
  }

  /**
   *
   */
  public function buildForm(array $form, FormStateInterface $form_state) {
    $form['email'] = [
      '#type' => 'email',
      '#title' => $this->t('Your email'),
    ];
    $form['actions']['#type'] = 'actions';
    $form['actions']['submit'] = [
      '#type' => 'submit',
      '#value' => $this->t('Save'),
      '#button_type' => 'primary',
    ];
    return $form;
  }

  /**
   *
   */
  public function submitForm(array &$form, FormStateInterface $form_state) {
    /* $this->messenger()->addStatus($this->t('Your email is @number', ['@number' => $form_state->getValue('phone_number')]));*/
  }

}
