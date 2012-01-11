## GitHub Issues

GitHub Issues is a lightweight jQuery UI based interface, which allows you to easily add issues to the GitHub issue tracker via the GitHub API.

***Disclaimer***: This gem uses GitHub's V3 API, which is still under development, so things may need to change as they are still changing the API's interface.

This gem also requires Rails 3.1.

### GitHub API V3

The GitHub API interaction for this gem is provided by the github-v3-api gem <https://github.com/jwilger/github-v3-api>.  The API requires an OAuth2 token, which is a bit of a pain to generate.  Luckily the github-v3-api gem makes this process fairly painless.  Follow github-v3-api gem's README for directions on how to generate the token.

***Note***: Part of getting your token involves registering your application with GitHub.  The GitHub account that you register your application under, and then generate the OAuth2 token for, will be the account that all issues are added to the issue tracker under via the GitHub Issues gem.  (We'll show you how to add a bit more application specific information to the issue a bit later.) 

### Adding To A Rails App

#### Add config file:

Once you've acquired the OAuth2 token for the GitHub API, you can add a github_issues.yml file to your application's config directory.  The file will look like this:

/config/github_issues.yml

    development:
      github_token: 
      user: 
      repo: 
    
    production:
      github_token: 
      user: 
      repo: 
    
    test:
      github_token: 
      user: 
      repo: 

This should be self explanatory, but the user and the repo are the user and repo of the application you are submitting issues for (presumably the application you are adding this github_issues.yml file to.)

#### Add the gems to your Gemfile:

Gemfile

    gem 'github-v3-api'
    gem 'github_issues', :git => "git@github.com:onehouse/Github-Issues.git"

#### Add the CSS and JS to your asset pipeline:

/app/assets/stylesheets/application.scss

    @import "github_issues/application";

/app/assets/javascripts/application.coffee

    #= require github_issues/application

***or…***

you could just add these to your layout

/app/views/layouts/application.html.haml

    = stylesheet_link_tag 'github_issues/application'
    = javascript_include_tag "github_issues/application"

#### Add the helper method call to one of your templates:

/app/views/layouts/application.html.haml

    = github_issues

That should be it.  If everything is in place, you should see a "new issue" link on the side of the page(s) you added the helper to.  Clicking it should bring up the new issue form in a jQuery UI dialog box, and submitting the form should add the issue to your application's issue tracker.

#### It's not working:

Do you have the right OAuth2 token, or are you trying to just use your GitHub API key in the github_token section of the yml config file?  This seems like an easy mistake to make.  If you think this might be your issue, check out the README for the <https://github.com/jwilger/github-v3-api> gem.  It'll walk you through the process of getting the right token.

### Adding a bit of application specific info to the issue

The GitHub issue tracker has two fields, title and body.  You can use the github_issues helper to add values to prepend or append additional data to either of these fields:

/app/views/layouts/application.html.haml

    = github_issues :prepend_title => "before title ",
                    :append_title => " after title", 
                    :prepend_body => "before body ",
                    :append_body => " after body"

#### A useful example:

/app/views/layouts/application.html.haml

    = github_issues :prepend_body => prepend_github_issue_string(@current_user, request.fullpath)

/app/helpers/github_issues_helper.rb

(Note: GitHub's issue tracker accepts MarkDown syntax in the issue body.)

    module GithubIssuesHelper
      def prepend_github_issue_string(user, path)
        more_info_string = "### Submitted From My Awesome Site:\r\r"
        more_info_string += "    Rails environment: #{Rails.env}\r"
        more_info_string += "    Current path: #{path}\r"
        if user.present?
          more_info_string += "    Submitted by: #{user.full_name} (ID:#{user.id})\r\r"
        end
      end
    end