GithubIssues::Engine.routes.draw do
  resources :issues, :only => [:new, :create]
end
