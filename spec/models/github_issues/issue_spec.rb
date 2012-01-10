require 'spec_helper'

describe GithubIssues::Issue do
  it "is a class" do
    GithubIssues.should be_kind_of(Object)
  end

  describe 'validations' do
    it "makes sure the title isn't blank" do
      @issue = GithubIssues::Issue.new({:title => "", :body => "some text"})
      @issue.should_not be_valid
      @issue.errors.full_messages.include?("Title can't be blank").should be_true
    end

    it "makes sure the body isn't blank" do
      @issue = GithubIssues::Issue.new({:title => "some text", :body => ""})
      @issue.should_not be_valid
      @issue.errors.full_messages.include?("Body can't be blank").should be_true
    end

    it "should be valid" do
      @issue = GithubIssues::Issue.new({:title => "some text", :body => "some text"})
      @issue.should be_valid
    end
  end
end
