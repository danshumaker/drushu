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
function drushu_install_tasks(&$task, $url) {
 // Insert default pre-defined node types into the database. For a complete
  // list of available node type attributes, refer to the node type API
  // documentation at: http://api.drupal.org/api/HEAD/function/hook_node_info.
  print "\nINSIDE THE PROFILE_TASKS funciton\n";
  $types = array(
    array(
      'type' => 'page',
      'name' => st('Basic page'),
      'base' => 'node_content',
      'description' => st("Use <em>basic pages</em> for your static content, such as an 'About us' page."),
      'custom' => 1,
      'modified' => 1,
      'locked' => 0,
    ),
  );

  foreach ($types as $type) {
    $type = node_type_set_defaults($type);
    node_type_save($type);
    node_add_body_field($type);
  }
 
  // Default page to not be promoted and have comments disabled.
  variable_set('node_options_page', array());
  variable_set('node_preview_page', '0');
  variable_set('node_submitted_page', 0);
 
  // Don't display date and author information for page nodes by default.
  $theme_settings = variable_get('theme_settings', array());
  $theme_settings['default_favicon'] = FALSE;
  $theme_settings['favicon_path'] = 'drushu.ico';
  $theme_settings['favicon_mimetype'] = 'image/vnd.microsoft.icon';
  variable_set('theme_settings', $theme_settings);
 
  // Clear caches.
  /*
  drupal_flush_all_caches();
 
  // Turn all other themes off
  db_query("UPDATE {system} SET status = 0 WHERE type = 'theme'");

  db_update('system')
      ->fields(array('status' => 1))
      ->condition('type', 'theme')
      ->condition('name', 'drushu')
      ->execute();
  variable_set('admin_theme', 'drushu');
   */
 // Any themes without keys here will get numeric keys and so will be enabled, but not placed into variables.
  $enable = array(
    'theme_default' => 'drushu',
    'admin_theme' => 'drushu',
    //'zen'
  );
  theme_enable($enable);

  foreach ($enable as $var => $theme) {
    if (!is_numeric($var)) {
      variable_set($var, $theme);
    }
  }
  variable_set('node_admin_theme', 1);

  // Disable the default Bartik theme
  theme_disable(array('bartik'));

  // Disable all blocks for current theme
  //db_query("UPDATE {blocks} SET region = '' WHERE theme = 'drushu'");

  variable_set('user_register', USER_REGISTER_ADMINISTRATORS_ONLY);
 
  // Set default WYSIWYG settings
  //db_query('INSERT INTO {wysiwyg} VALUES (1,\'\',NULL),(2,\'ckeditor\',\'a:20:{s:7:"default";i:1;s:11:"user_choose";i:0;s:11:"show_toggle";i:1;s:5:"theme";s:8:"advanced";s:8:"language";s:2:"en";s:7:"buttons";a:2:{s:7:"default";a:2:{s:4:"Bold";i:1;s:5:"Image";i:1;}s:4:"imce";a:1:{s:4:"imce";i:1;}}s:11:"toolbar_loc";s:3:"top";s:13:"toolbar_align";s:4:"left";s:8:"path_loc";s:6:"bottom";s:8:"resizing";i:1;s:11:"verify_html";i:1;s:12:"preformatted";i:0;s:22:"convert_fonts_to_spans";i:1;s:17:"remove_linebreaks";i:1;s:23:"apply_source_formatting";i:0;s:27:"paste_auto_cleanup_on_paste";i:0;s:13:"block_formats";s:32:"p,address,pre,h2,h3,h4,h5,h6,div";s:11:"css_setting";s:5:"theme";s:8:"css_path";s:0:"";s:11:"css_classes";s:0:"";}\')');
 
  // Set default input format to Full HTML
  variable_set('filter_default_format', '2');
 
  // Make old cache files be immediately deleted upon clear_cache
  variable_set('drupal_stale_file_handle', 1);
 
  // Pathauto default path
  //variable_set('pathauto_node_pattern', '[title-raw]');
 
  // Make an 'editor' role
  //db_query("INSERT INTO {role} (rid, name) VALUES (3, 'editor')");
 
  // Change anonymous user's permissions - this is UPDATE rather than INSERT
  //db_query("UPDATE {permission} SET perm = 'access comments, can send feedback, access content, search content, view uploaded files' WHERE rid = 1");
 
  // Change authenticated user's permissions - this is UPDATE rather than INSERT
  //db_query("UPDATE {permission} SET perm = CONCAT(perm, ', search content, view uploaded files') WHERE rid = 2");
 
 
  // Allow editor role to use admin bar + other default editor permissions
  //db_query("INSERT INTO {permission} (rid, perm, tid) VALUES (3, 'use admin toolbar, collapse format fieldset by default, collapsible format selection, show format selection for blocks, show format selection for comments, show format selection for nodes, show format tips, show more format tips link, administer blocks, access comments, administer comments, post comments, post comments without approval, access content, administer nodes, create page content, delete any page content, delete own page content, delete revisions, edit any page content, edit own page content, revert revisions, view revisions, search content, view uploaded files, administer users',0)");
  //
  // Enable default permissions for system roles.
  $filtered_html_permission = filter_permission_name($filtered_html_format);
  user_role_grant_permissions(DRUPAL_ANONYMOUS_RID, array('access content', 'access comments', $filtered_html_permission));
  user_role_grant_permissions(DRUPAL_AUTHENTICATED_RID, array('access content', 'access comments', 'post comments', 'skip comment approval', $filtered_html_permission));

  // Create a default role for site administrators, with all available permissions assigned.
  $admin_role = new stdClass();
  $admin_role->name = 'administrator';
  $admin_role->weight = 2;
  user_role_save($admin_role);
  user_role_grant_permissions($admin_role->rid, array_keys(module_invoke_all('permission')));
  // Set this as the administrator role.
  variable_set('user_admin_role', $admin_role->rid);

  // Assign user 1 the "administrator" role.
  db_insert('users_roles')->fields(array('uid' => 1, 'rid' => $admin_role->rid))->execute();
}
?>
