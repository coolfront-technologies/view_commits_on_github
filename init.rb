require 'redmine'
require 'repositories_controller'


Redmine::Plugin.register :view_commits_on_github do
  name 'View Commits on Github'
  author 'Matt Smith'
  description 'This plugin redirects to github when viewing commits.'
  settings({
    :default => {},
    :partial => 'settings/github_settings',
  })

  RepositoriesController.send(:include, RepositoriesControllerPatch)

end