require 'spec_helper'

describe "Votes" do
  let!(:user)     { Factory(:user) }
  let!(:comment)  { Factory(:comment, :commentable => article, :user => user, :votes => [vote3]) }
  let!(:vote1)    { Factory(:vote, :value => true, :user => user) }
  let!(:vote2)    { Factory(:vote, :value => true) }
  let!(:vote3)    { Factory(:vote, :value => true, :user => user) }
  let(:article)   { Factory(:article, :votes => [vote1, vote2], :user => user )}
  
  before(:each) do
    visit article_path(article)
  end
  
  describe "when viewing a votable object before voting" do
    
    it "should display the vote count for article and comment" do    
      page.should have_content('2')
      page.should have_content('1')
    end
    
    it "should show the upvote and downvote arrows" do
      page.should have_xpath("//img[@src = '/assets/up.png']")
      page.should have_xpath("//img[@src = '/assets/down.png']")
    end
  end
  
  describe "when viewing a votable object after voting" do
    before do
      log_in
      visit article_path(article)
    end
    
    it "should not display the upvote and downvote arrows" do
      page.should_not have_xpath("//img[@src = '/assets/up.png']")
      page.should_not have_xpath("//img[@src = '/assets/down.png']")
    end
  end
end