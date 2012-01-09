module GithubIssues
  module ApplicationHelper
    def github_issue_dialog
      @issue = Issue.new
      render "github_issues/issues/new"
    end
  end
end
