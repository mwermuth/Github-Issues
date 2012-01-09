module GithubIssues
  class IssuesController < ApplicationController
    def create
      respond_to do |format|
        format.js do
          @issue = Issue.new(params[:github_issues_issue])
          if @issue.valid?
            render "create_success"
          else
            render "create_error"
          end
        end
      end
    end
  end
end
