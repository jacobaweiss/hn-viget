def log_in
  visit '/login'
  fill_in 'Email', :with => 'lindsey@bluth.org'
  fill_in 'Password', :with => 'beads'
  click_button('Log in')
end
