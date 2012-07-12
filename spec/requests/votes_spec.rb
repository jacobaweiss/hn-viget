# encoding: utf-8
require_relative '../spec_helper'

describe "Votes" do
  let!(:user)     { Factory(:user) }
  let!(:article)  { Factory(:article, :user => user) }
  let!(:comment)  { Factory(:comment, :commentable => article, :user => user) }
  let!(:vote1)    { Factory(:vote, :value => true, :user => user, :votable => article) }
  let!(:vote2)    { Factory(:vote, :value => true, :votable => article) }
  let!(:vote3)    { Factory(:vote, :value => true, :user => user, :votable => comment) }
  
  before(:each) do
    visit article_path(article)
  end
  
  describe "when viewing a votable object before voting" do
    
    it "should display the vote count for article and comment" do
      page.should have_content('2')
      page.should have_content('1')
    end
    
    it "should show the upvote and downvote arrows" do
      page.should have_content("▲")
      page.should have_content("▼")
    end
  end
  
  describe "when viewing a votable object after voting" do
    before do
      log_in
      visit article_path(article)
    end
    
    it "should not display the upvote and downvote arrows" do
      page.should_not have_content("▲")
      page.should_not have_content("▼")
    end
  end
end