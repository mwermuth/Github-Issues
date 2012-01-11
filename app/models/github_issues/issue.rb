module GithubIssues
  class Issue
    include ActiveModel::Validations
    extend ActiveModel::Callbacks

    define_model_callbacks :save

    before_save :appends_and_prepends
    
    attr_accessor :title, :body, :append_title, :prepend_title, :append_body, :prepend_body

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
      run_callbacks :save do
        params = {:title => title, :body => body}
        api = GitHubV3API.new(@config["github_token"])
        api.issues.create(@config["user"], @config["repo"], params)
      end
      true
    end

  private

    def appends_and_prepends
      self.title = "#{self.prepend_title}#{self.title}#{self.append_title}"
      self.body = "#{self.prepend_body}#{self.body}#{self.append_body}"
    end
  end
end
