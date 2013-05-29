<?php
/**
* Return a description of the profile for the initial installation screen.
*
* @return
*   An array with keys 'name' and 'description' describing this profile.
*/
function drushu_profile_details() {
  return array(
    'name' =>'drushu',
    'description' => 'Base install profile for Shumaker Drupal sites.',
  );
}
 
/**
 * Implementation of hook_install_tasks().
 *
 * It's safer to run functions in this hook as apposed to the
 * hook_profile_install() function in the .install file because
 * we are guaranteed a full bootstrap here and not there.
 */
function drushu_install_tasks($install_state) {
  $tasks['chmodfiles'] = array(
    'display_name' => st('Set dir permissions to 777 for files'),
    'display' => TRUE,
    'type' => 'batch',
    'run' => INSTALL_TASK_RUN_IF_NOT_COMPLETED,
    'function' => 'chmodfiles',
  );
  $tasks['ckeditor_set'] = array(
    'display_name' => st('Set ckeditor formats'),
    'display' => TRUE,
    'type' => 'batch',
    'run' => INSTALL_TASK_RUN_IF_NOT_COMPLETED,
    'function' => 'ckeditor_set',
  );

return $tasks;
}

function chmodfiles() {
 chmod( DRUPAL_ROOT . '/sites/default/files', 777);
}
function ckeditor_set() {
   db_update('wysiwyg')->fields(array('editor' => 'ckeditor',))
     ->condition('format','filtered_html')
     ->execute();
}
?>
