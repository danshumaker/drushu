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
  print "INSIDE drushu_install_tasks";
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
 $dir = DRUPAL_ROOT . '/sites/default/files';
 $res = chmod( $dir, 777);
 print "chmoded " . $dir;
 if ($res) {
   print "\nsucess\n";
 } else {
   print "\nfailed\n";
}
function ckeditor_set() {
   $record = array('editor' => 'ckeditor', 'format' => 'filtered_html');
   $res = drupal_write_record('wysiwyg', $record);
   if ($res) {
     print "\nsucess\n";
   } else {
     print "\nfailure\n";
   }
}
?>
