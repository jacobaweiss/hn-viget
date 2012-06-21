require 'spec_helper'

describe "Comments" do
  let!(:user) { Factory(:user) }
  let!(:comment) { Factory(:comment, :user => user, :comments => [nested_comment] ) }
  let!(:expired_comment) { Factory(:comment, :user => user, :created_at => (Time.now - 20.minutes)) }
  let!(:nested_comment) { Factory(:comment, :user => user, :content => "This is a nested comment.") }
  let!(:article) { Factory(:article, :comments => [expired_comment, comment], :user => user) }

  describe "viewed on an article page" do
    before { visit article_path(article) }

    it "should show all comments" do
      page.should have_content('This is a comment.')
      page.should have_content('This is a nested comment.')
    end
  
    describe "when user is not logged in" do
      it "cannot create a comment" do
        click_link "Add a comment"
        page.should have_content('You must be logged in to access this section')
      end
    end
  
    describe "when user is logged in" do
      before do
        log_in
        visit article_path(article)
      end
      
      it "can comment on an article" do
        click_link "Add a comment"
        fill_in 'Leave a comment', :with => "I just made a new comment"
        click_button 'Add Comment'
      
        page.should have_content('Your comment has been saved!')
      end
    
      it "can reply to a comment" do
        click_link "Reply"
        fill_in 'Leave a comment', :with => "I just made a new comment"
        click_button 'Add Comment'
      
        page.should have_content('Your comment has been saved!')
      end

      it "can edit user's own comment" do
        click_link 'Edit Comment'
        
        fill_in 'Leave a comment', :with => "This comment has been edited!"
        click_button 'Update Comment'
        
        page.should have_content('This comment has been edited!')
      end
      
      it "cannot edit a comment after 5 minutes" do
        visit "#{expired_comment.article.id}/comments/#{expired_comment.id}/edit"
     
        page.should have_content('Too much time has passed to update this comment.')
      end
      
    end
  end

end