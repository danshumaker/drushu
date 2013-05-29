<!--?php
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
* Return an array of the modules to be enabled when this profile is installed.
*
* @return
*  An array of modules to be enabled.
*/
function drushu_profile_modules() {
  /* leaving as example
  // But the modules are automatically enabled
  // via the .info file.
 return array(
    'views',
    'views_ui',
  );
   */
}
 
/**
 * Implementation of hook_profile_tasks().
 *
 * It's safer to run functions in this hook as apposed to the
 * hook_profile_install() function in the .install file because
 * we are guaranteed a full bootstrap here and not there.
 */
function drushu_profile_tasks(&$task, $url) {
  // Insert default user-defined node types into the database.
  $types = array(
    array(
      'type' => 'page',
      'name' => t('Page'),
      'module' => 'node',
      'description' => t('If you want to add a static page, like a contact page or an about page, use a page.'),
      'custom' => TRUE,
      'modified' => TRUE,
      'locked' => FALSE,
    ),
  );
 
  foreach ($types as $type) {
    $type = (object) _node_type_set_defaults($type);
    node_type_save($type);
  }
 
  // Default page to not be promoted and have comments disabled.
  variable_set('node_options_page', array('status'));
  variable_set('comment_page', COMMENT_NODE_DISABLED);
 
  // Don't display date and author information for page nodes by default.
  $theme_settings = variable_get('theme_settings', array());
  $theme_settings['default_favicon'] = FALSE;
  $theme_settings['favicon_path'] = 'drushu.ico';
  $theme_settings['favicon_mimetype'] = 'image/vnd.microsoft.icon';
  variable_set('theme_settings', $theme_settings);
 
  // Clear caches.
  drupal_flush_all_caches();
 
  // Turn all other themes off
  db_query("UPDATE {system} SET status = 0 WHERE type = 'theme'");

  db_update('system')
      ->fields(array('status' => 1))
      ->condition('type', 'theme')
      ->condition('name', 'drushu')
      ->execute();
  variable_set('admin_theme', 'drushu');
  variable_set('node_admin_theme', 1);

  // Disable all blocks for current theme
  db_query("UPDATE {blocks} SET region = '' WHERE theme = 'drushu'");

  variable_set('user_register', USER_REGISTER_ADMINISTRATORS_ONLY);
  variable_set('theme_default', 'drushu');
 
  // Set default WYSIWYG settings
  db_query('INSERT INTO {wysiwyg} VALUES (1,\'\',NULL),(2,\'ckeditor\',\'a:20:{s:7:"default";i:1;s:11:"user_choose";i:0;s:11:"show_toggle";i:1;s:5:"theme";s:8:"advanced";s:8:"language";s:2:"en";s:7:"buttons";a:2:{s:7:"default";a:2:{s:4:"Bold";i:1;s:5:"Image";i:1;}s:4:"imce";a:1:{s:4:"imce";i:1;}}s:11:"toolbar_loc";s:3:"top";s:13:"toolbar_align";s:4:"left";s:8:"path_loc";s:6:"bottom";s:8:"resizing";i:1;s:11:"verify_html";i:1;s:12:"preformatted";i:0;s:22:"convert_fonts_to_spans";i:1;s:17:"remove_linebreaks";i:1;s:23:"apply_source_formatting";i:0;s:27:"paste_auto_cleanup_on_paste";i:0;s:13:"block_formats";s:32:"p,address,pre,h2,h3,h4,h5,h6,div";s:11:"css_setting";s:5:"theme";s:8:"css_path";s:0:"";s:11:"css_classes";s:0:"";}\')');
 
  // Set default input format to Full HTML
  variable_set('filter_default_format', '2');
 
  // Make old cache files be immediately deleted upon clear_cache
  variable_set('drupal_stale_file_handle', 1);
 
  // Pathauto default path
  variable_set('pathauto_node_pattern', '[title-raw]');
 
  // Make an 'editor' role
  db_query("INSERT INTO {role} (rid, name) VALUES (3, 'editor')");
 
  // Change anonymous user's permissions - this is UPDATE rather than INSERT
  db_query("UPDATE {permission} SET perm = 'access comments, can send feedback, access content, search content, view uploaded files' WHERE rid = 1");
 
  // Change authenticated user's permissions - this is UPDATE rather than INSERT
  db_query("UPDATE {permission} SET perm = CONCAT(perm, ', search content, view uploaded files') WHERE rid = 2");
 
 
  // Allow editor role to use admin bar + other default editor permissions
  db_query("INSERT INTO {permission} (rid, perm, tid) VALUES (3, 'use admin toolbar, collapse format fieldset by default, collapsible format selection, show format selection for blocks, show format selection for comments, show format selection for nodes, show format tips, show more format tips link, administer blocks, access comments, administer comments, post comments, post comments without approval, access content, administer nodes, create page content, delete any page content, delete own page content, delete revisions, edit any page content, edit own page content, revert revisions, view revisions, search content, view uploaded files, administer users',0)");
}
?>
