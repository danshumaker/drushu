; DruShu Make file
core = 7.x
api = 2

projects[] = "drupal"
; Include Drupal core and any core patches.
; includes[] = drupal-org-core.make

; Profiles ====================================================================
;projects[buildkit][type] = profile
;projects[buildkit][download][type] = git
;projects[buildkit][download][url] = http://git.drupal.org/project/buildkit.git
;projects[buildkit][download][branch] = 7.x-2.0-beta4

; Includes ====================================================================
includes[] = http://drupalcode.org/project/buildkit.git/blob_plain/dd1c740967b139a03002848bc1ec83e20ca929f7:/drupal-org.make
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
; projects[fontyourface][subdir] = "contrib"
projects[ctools][subdir] = "contrib"
projects[devel][subdir] = "contrib"
projects[libraries][subdir] = "contrib"
projects[node_export][subdir] = "contrib"
projects[views][subdir] = "contrib"
projects[admin_menu][subdir] = "contrib"
projects[ckeditor][subdir] = "contrib"
projects[module_filter][subdir] = "contrib"
projects[examples][subdir] = "contrib"
projects[advanced_help][subdir] = "contrib"
projects[coder][subdir] = "contrib"

; Themes ======================================================================
projects[] = "zen"
;projects[omega_tm][download][type] = "git"
;projects[omega_tm][download][url] = "dshumaker@git.drupal.org:sandbox/dshumaker/1638120.git"
;projects[omega_tm][type] = "theme"

