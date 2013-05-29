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
  $dir = DRUPAL_ROOT . '/sites/default/files';
  $res = chmod( $dir, 0777);
  print "chmoded " . $dir;
  if ($res) {
    print "\nsucess\n";
  } else {
    print "\nfailed\n";
    }
}
function ckeditor_set() {
   $record = array('editor' => 'ckeditor', 'format' => 'filtered_html', 'settings' => 'a:20:{s:7:"default";i:1;s:11:"user_choose";i:0;s:11:"show_toggle";i:1;s:5:"theme";s:8:"advanced";s:8:"language";s:2:"en";s:7:"buttons";a:2:{s:7:"default";a:33:{s:4:"Bold";i:1;s:6:"Italic";i:1;s:11:"JustifyLeft";i:1;s:13:"JustifyCenter";i:1;s:12:"JustifyBlock";i:1;s:12:"BulletedList";i:1;s:12:"NumberedList";i:1;s:7:"Outdent";i:1;s:6:"Indent";i:1;s:4:"Undo";i:1;s:4:"Redo";i:1;s:4:"Link";i:1;s:6:"Anchor";i:1;s:5:"Image";i:1;s:9:"TextColor";i:1;s:7:"BGColor";i:1;s:10:"Blockquote";i:1;s:6:"Source";i:1;s:14:"HorizontalRule";i:1;s:5:"Paste";i:1;s:10:"ShowBlocks";i:1;s:12:"RemoveFormat";i:1;s:11:"SpecialChar";i:1;s:6:"Format";i:1;s:4:"Font";i:1;s:8:"FontSize";i:1;s:6:"Styles";i:1;s:5:"Table";i:1;s:6:"Smiley";i:1;s:9:"CreateDiv";i:1;s:8:"Maximize";i:1;s:12:"SpellChecker";i:1;s:5:"Scayt";i:1;}s:6:"drupal";a:1:{s:5:"break";i:1;}}s:11:"toolbar_loc";s:3:"top";s:13:"toolbar_align";s:4:"left";s:8:"path_loc";s:6:"bottom";s:8:"resizing";i:1;s:11:"verify_html";i:1;s:12:"preformatted";i:0;s:22:"convert_fonts_to_spans";i:1;s:17:"remove_linebreaks";i:1;s:23:"apply_source_formatting";i:0;s:27:"paste_auto_cleanup_on_paste";i:0;s:13:"block_formats";s:32:"p,address,pre,h2,h3,h4,h5,h6,div";s:11:"css_setting";s:5:"theme";s:8:"css_path";s:0:"";s:11:"css_classes";s:0:"";}');
   $record = array('editor' => 'ckeditor', 'format' => 'full_html');
   $res = drupal_write_record('wysiwyg', $record);
   if ($res) {
     print "\nsucess\n";
   } else {
     print "\nfailure\n";
   }
}
?>
