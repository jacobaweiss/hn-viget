# encoding: utf-8
require_relative '../spec_helper'

describe "Users" do  
  let!(:user)    { Factory(:user) }
  let!(:article) { Factory(:article, :user => user) }
  describe "when viewing as a visitor" do
    it "allows users to sign up" do
      visit '/signup'

      fill_in 'Email', :with => 'buster@bluth.org'
      fill_in 'Password', :with => 'foobar'
      fill_in 'Password confirmation', :with => 'foobar'

      click_button('Create Account')
    
      page.should have_content('Your account has been successfully created!')
    end
    
    it "requires new sign up info" do
      visit '/signup'

      fill_in 'user_email', :with => 'lindsey@bluth.org'
      fill_in 'user_password', :with => 'foobar'
      fill_in 'user_password_confirmation', :with => 'foobar'

      click_button('Create Account')
      page.should have_content("Email has already been taken")
    end
    
    describe "when trying to vote" do
      it "should redirect to login page" do
        visit article_vote_path(article, :value => true)
        page.should have_content('Forgot your password?')        
      end
    end
  end
  
  describe "when logged in" do
    before { log_in }
    it "should log in user" do
      page.should have_content('You are now logged in!')
    end
    
    it "can sign out" do
      visit '/'
      click_link 'Log Out'
      page.should have_content('You have been signed out!')
    end
    
    it "can change user's password" do
      visit '/change_password'
      fill_in 'New password', :with => 'carl'
      fill_in 'Confirm new password', :with => 'carl'
      click_button 'Change Password'
      page.should have_content('Your password has been changed!')
    end
    
    describe "voting" do
      
      it "can vote on an article" do
        visit article_vote_path(article, :value => true)
        page.should have_content('1')
      end
      
      describe "once voted" do
        let!(:vote)   { Factory(:vote, :value => true, :user => user) }
        let!(:comment) { Factory(:comment, :user => user, :votes => [vote]) }
        
        before do
          visit article_vote_path(article, :value => true)
          page.should have_content('1')
        end
        
        it "should not have images" do
          page.should_not have_content("▲")
          page.should_not have_content("▼")
        end
        
        it "cannot vote again" do
          visit article_vote_path(article, :value => true)
          page.should have_content('You have already voted on this.')
        end
        
        it "should update user's karma" do
          visit user_path(user)
          page.should have_content('2')
        end
      end
    end
  end
end