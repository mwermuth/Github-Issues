Rails.application.routes.draw do

  mount GithubIssues::Engine => "/github_issues"
end
