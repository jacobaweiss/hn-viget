def log_in
  # @user = User.create!(:email => 'gob@bluth.org', :password => 'tricks', :password_confirmation => 'tricks')    
  visit '/login'
  fill_in 'email', :with => 'lindsey@bluth.org'
  fill_in 'password', :with => 'beads'
  click_button('Log in')
end
