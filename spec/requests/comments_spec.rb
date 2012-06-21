require 'spec_helper'

describe "Comments" do
  let!(:user) { Factory(:user) }
  let!(:comment) { Factory(:comment, :user => user, :comments => [nested_comment] ) }
  let!(:nested_comment) { Factory(:comment, :user => user, :content => "This is a nested comment.") }
  let(:article) { Factory(:article, :comments => [comment]) }
  
  describe "viewed on an article page" do
    
    it "should show all comments" do
      visit article_path(article)
      page.should have_content('This is a comment.')
      page.should have_content('This is a nested comment.')
    end    
  end
end