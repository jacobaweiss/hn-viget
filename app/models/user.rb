class User < ActiveRecord::Base
  include SimplestAuth::Model
  
  has_many :articles
  has_many :comments
  has_many :votes, dependent: :destroy
  
  attr_accessible :email, :password, :password_confirmation
  attr_accessor :password
  
  validates :email, :presence => true, :uniqueness => { :case_sensitive => false }
  validates :password, :confirmation => true
  validates :password_confirmation, :presence => true
  
  authenticate_by :email
  
  def has_voted?(votable)
    votable.votes.find_by_user_id(self.id).present?
  end
  
  def karma
    karma = 0
    if self.articles.any?
      karma += self.articles.map { |a| a.reputation }.reduce(&:+)
    end
    if self.comments.any?
      karma += self.comments.map { |c| c.reputation }.reduce(&:+)
    end
    
    return karma
  end  
end