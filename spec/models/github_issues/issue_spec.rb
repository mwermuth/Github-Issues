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

  describe "call backs" do
    it "applies a before save filter" do
      GithubIssues::Issue.class_eval do
        def add_text_to_body
        end
      end
      GithubIssues::Issue.instance_eval do
        before_save :add_text_to_body
      end
      @issue = GithubIssues::Issue.new({:title => "some text", :body => "some text"})
      @issue.methods.include?(:add_text_to_body).should be_true
      obj_1 = Object.new
      obj_2 = Object.new
      GitHubV3API.should_receive(:new).and_return(obj_1)
      obj_1.should_receive(:issues).and_return(obj_2)
      obj_2.should_receive(:create).and_return(true)
      @issue.should_receive(:add_text_to_body)
      @issue.save
    end
  end
end
