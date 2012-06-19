require 'spec_helper'

describe "Users" do  
  let!(:user) { Factory(:user) }
  describe "when viewing as a visitor" do
    it "allows users to sign up" do
      visit '/signup'

      fill_in 'Email', :with => 'buster@bluth.org'
      fill_in 'Password', :with => 'foobar'
      fill_in 'Password confirmation', :with => 'foobar'

      click_button('Create User')
    
      page.should have_content('Your account has been successfully created!')
    end
    
    it "requires new sign up info" do
      visit '/signup'

      fill_in 'user_email', :with => 'lindsey@bluth.org'
      fill_in 'user_password', :with => 'foobar'
      fill_in 'user_password_confirmation', :with => 'foobar'

      click_button('Create User')
      page.should have_content("Email has already been taken")
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
  end
end