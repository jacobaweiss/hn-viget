namespace :db do
  desc "Erase and Fill the database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    User.delete_all
    Article.delete_all
    
    50.times do
      @user = User.create(:email => Faker::Internet.email,
                          :password => "foo",
                          :password_confirmation => "foo")
      
      4.times do
        @user.articles.create(:title => Faker::Lorem.sentence,
                              :url   => Faker::Internet.url,
                              :text  => Faker::Lorem.sentence)
      end
    end
  end
end