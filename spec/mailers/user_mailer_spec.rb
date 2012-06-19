require "spec_helper"

describe UserMailer do
  let!(:user) { Factory.build(:user) }
  before(:all) { @email = UserMailer.reset_password(user) }
  
  it "should deliver the email when requested" do
    @email.should deliver_to "lindsey@bluth.org"
  end
  
  it "should have the right content" do
    @email.should have_content('Reset your password')
    @email.should have_link(change_password_path)
  end
end