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
}
?>
