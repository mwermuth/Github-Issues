class GithubIssue
  include ActiveModel::Validations
  
  attr_accessor :title, :message

  validates :title, :presence => true
  validates :message, :presence => true

  def initialize(params = {})
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
end
