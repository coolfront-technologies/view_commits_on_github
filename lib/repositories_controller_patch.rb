# patch the revision action to redirect to github
module RepositoriesControllerPatch

  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable # prevent unloading in development mode
      alias_method :original_revision, :revision
      alias_method :revision, :github_revision
    end
  end

  module InstanceMethods

    def github_revision
      url = github_url
      if url.blank?
        original_revision
      else
        redirect_to url
      end
    end


    def github_url
      projects_github = Setting.plugin_view_commits_on_github
      return if projects_github.blank?

      github_repo = projects_github[@changeset.project.identifier]
      return if github_repo.blank?

      return "https://github.com/#{github_repo}/commit/#{@changeset.scmid}"
    end

  end

end

