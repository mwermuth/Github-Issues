Rails.application.routes.draw do
  mount GithubIssues::Engine => "/github_issues", :as => "github_issues"
  root :to => "pages#home"
end

