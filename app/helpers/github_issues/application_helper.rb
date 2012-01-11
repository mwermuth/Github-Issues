module GithubIssues
  module ApplicationHelper
    def github_issues
      @issue = Issue.new
      render "github_issues/issues/new"
    end
  end
end
