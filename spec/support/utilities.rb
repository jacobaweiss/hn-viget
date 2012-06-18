def log_in
  @user = User.create!(:email => 'gob@bluth.org', :password => 'tricks', :password_confirmation => 'tricks')    
  visit '/login'
  fill_in 'email', :with => 'gob@bluth.org'
  fill_in 'password', :with => 'tricks'
  click_button('Log in')
end

def make_post
  @article = @user.articles.create(:title => "Bob Loblaw's Law Blog", :text => "Is she funny or something?")
  visit "/articles/#{@article.id}/edit"
end

def sign_up
  visit '/signup'

  fill_in 'user_email', :with => 'buster@bluth.org'
  fill_in 'user_password', :with => 'foobar'
  fill_in 'user_password_confirmation', :with => 'foobar'

  click_button('Create User')
end