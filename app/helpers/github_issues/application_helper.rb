module GithubIssues
  module ApplicationHelper
    def github_issues(attributes = {})
      @issue = Issue.new
      %w{prepend_title append_title prepend_body append_body}.each do |field|
        @issue.send("#{field}=", attributes[:"#{field}"]) if attributes[:"#{field}"].present?
      end
      render "github_issues/issues/new"
    end
  end
end
