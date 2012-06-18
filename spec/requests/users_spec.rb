require 'spec_helper'

describe "Users" do  
  describe "when viewing as a visitor" do
    # must re-prepare test db for this test to work
    it "allows users to sign up" do
      visit '/signup'

      fill_in 'user_email', :with => 'buster@bluth.org'
      fill_in 'user_password', :with => 'foobar'
      fill_in 'user_password_confirmation', :with => 'foobar'

      click_button('Create User')
    
      page.should have_content('Your account has been successfully created!')
    end
    
    it "requires new sign up info" do
      user = User.create(:email => "buster@bluth.org", :password => "foobar", :password_confirmation => "foobar")
      sign_up
      
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
  end
end