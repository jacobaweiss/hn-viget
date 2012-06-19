require 'spec_helper'

describe "Articles" do
  let(:user) { Factory(:user) }
  let!(:article) { Factory(:article, :user => user, :title => "Bob Loblaw's Law Blog", :text => "Is she funny or something?") }
  
  describe "as a visitor" do
    it "Visit the index" do
      visit '/'
      page.should have_content("Bob Loblaw's Law Blog")
    end
  
    it "visits an article page" do
      article = Article.first
      visit "/articles/#{article.id}"
    
      page.should have_content("Is she funny or something?")
    end
    
    it "cannot create an article" do
      visit '/articles/new'
      
      page.should have_content("You must be logged in to access this section")
    end
  end

  describe "as a user" do
    before { log_in }
    it "can create a new article" do
      visit '/articles/new'
  
      fill_in 'Title', :with => "Bees?"
      fill_in 'Text', :with => "No, beads!"
    
      click_button('Create Article')
    
      page.should have_content('Article was successfully created.')
    end
  
    it "won't create an invalid article" do
      visit "/articles/new"
    
      click_button('Create Article')
    
      page.should have_content('Article text or url must be present')
      page.should have_content("Title can't be blank")
    end
  
    it "can edit an article" do
      visit "/articles/#{article.id}/edit"
      
      fill_in 'Url', :with => 'http://foo.bar'
      click_button 'Update Article'
    
      visit "/articles/#{article.id}"
      page.should have_content('http://foo.bar')
    end
  
    it "cannot update an with invalid information" do
      visit "/articles/#{article.id}/edit"
    
      fill_in 'Text', :with => ''
      fill_in 'Url', :with => ''
      click_button 'Update Article'
  
      page.should have_content('Article text or url must be present')
    end
  
    it "can destroy a post" do
      visit "/"

      click_link "Destroy"
    
      page.should_not have_content("Bob Loblaw's Law Blog")
    end
  
  end

end
