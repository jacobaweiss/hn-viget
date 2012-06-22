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
    votable.votes.find_by_user_id(self)
  end

  def upvote(votable)
    if self.has_voted?(votable)
      votable.votes.find_by_user_id(self).destroy
    else
      votable.votes.build(:value => true, :user => self)
    end
  end
  
  def downvote(votable)
    if self.has_voted?(votable)
      votable.votes.find_by_user_id(self).destroy
    else
      votable.votes.build(:value => false, :user => self)
    end
  end
end
