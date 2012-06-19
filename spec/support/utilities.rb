def log_in
  visit '/login'
  fill_in 'email', :with => 'lindsey@bluth.org'
  fill_in 'password', :with => 'beads'
  click_button('Log in')
end
