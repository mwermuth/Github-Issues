GithubIssues::Engine.routes.draw do
  resources :issues, :only => [:create], :controller => "GithubIssues::Issues"
end
