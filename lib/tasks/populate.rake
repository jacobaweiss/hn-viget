namespace :db do
  desc "Erase and Fill the database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    Article.delete_all
    
    Article.populate 50 do |article|
      article.title = Faker::Lorem.sentence
      article.url =   Faker::Internet.url
      article.text =  Faker::Lorem.sentence
    end
  end
end