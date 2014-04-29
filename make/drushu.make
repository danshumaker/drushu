; DruShu Make file
; A make file is simply a list of things to download
; with sourse and detination settings.
; For configuration use a drush profile 
;  Put module enabling in the profile .info file.
;  Put variable settings and content creation in
;   the .profile file. 
;   You could use the profile install file but the 
;   .profile file (tasks) is better.
core = 7.x
api = 2

projects[] = "drupal"
; Include Drupal core and any core patches.
; includes[] = drupal-org-core.make

; Profiles ====================================================================
projects[drushu][type] = profile
projects[drushu][download][type] = git
projects[drushu][download][url] = https://github.com/danshumaker/drushu.git
projects[drushu][download][branch] = master

; Includes ====================================================================
;includes[] = http://drupalcode.org/project/buildkit.git/blob_plain/dd1c740967b139a03002848bc1ec83e20ca929f7:/drupal-org.make
;includes[] = "https://raw.github.com/makara/buildkit_plus_v7/master/base.make"

; Libraries ===================================================================
;libraries[superfish][download][type] = "git"
;libraries[superfish][download][url] = "git://github.com/mehrpadin/Superfish-for-Drupal.git"
;libraries[superfish][directory_name] = "superfish"
;libraries[superfish][type] = "library"

libraries[ckeditor][download][type] = "get"
libraries[ckeditor][download][url] = "http://download.cksource.com/CKEditor/CKEditor/CKEditor%203.3.1/ckeditor_3.3.1.tar.gz"
libraries[ckeditor][destination] = "libraries"

; Modules =====================================================================
projects[admin_menu][subdir] = "contrib"
projects[advanced_help][subdir] = "contrib"
projects[block_class][subdir] = "contrib"
projects[ckeditor][subdir] = "contrib"
projects[coder][subdir] = "contrib"
projects[ctools][subdir] = "contrib"
projects[devel][subdir] = "contrib"
projects[examples][subdir] = "contrib"
projects[libraries][subdir] = "contrib"
projects[module_filter][subdir] = "contrib"
projects[node_export][subdir] = "contrib"
projects[query_coder][subdir] = "contrib"
projects[token][subdir] = "contrib"
projects[transliteration][subdir] = "contrib"
projects[views][subdir] = "contrib"
projects[variable][subdir] = "contrib"
projects[wysiwyg][subdir] = "contrib"

; Themes ======================================================================
;projects[] = "drushu_theme"
projects[drushu_theme][download][type] = git
projects[drushu_theme][download][url] = https://github.com/danshumaker/drushu_theme.git
projects[drushu_theme][type] = "theme"

