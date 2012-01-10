module GithubIssues
  class Issue
    include ActiveModel::Validations
    
    attr_accessor :title, :body

    validates :title, :presence => true
    validates :body, :presence => true

    def initialize(params = {})
      @config = GithubIssues.config
      params.each do |key, value|
        send("#{key}=", value)
      end
    end

    def to_key
      nil
    end
    
    def to_model
      self
    end

    def save
      params = {:title => title, :body => body}
      api = GitHubV3API.new(@config["github_token"])
      api.issues.create(@config["user"], @config["repo"], params)
      true
    end
  end
end
