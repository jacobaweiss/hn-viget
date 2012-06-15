require 'spec_helper'

describe "Articles" do
  let!(:article) { Factory(:article, :title => 'Ruby Title', :text => 'stuff') }
  
  it "Visit the index" do
    visit '/'
    
    page.should have_content('Ruby Title')
  end
  
  it "visits an article page" do
    visit "/articles/#{article.id}"
    
    page.should have_content('stuff')
  end

  it "can create a new article" do
    visit '/articles/new'
    
    fill_in 'Title', :with => 'Ruby Title'
    fill_in 'Text', :with => 'This is an article'
    
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
  
  it "cannot update an invalid article" do
    visit "/articles/#{article.id}/edit"
    
    fill_in 'Text', :with => ''
    fill_in 'Url', :with => ''
    
    click_button 'Update Article'
  
    page.should have_content('Article text or url must be present')
  end
  
  it "can destroy a post" do
    visit "/"
    
    click_link "Destroy"
    
    page.should_not have_content('Ruby Title')
  end

end
