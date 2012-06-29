class Vote < ActiveRecord::Base
  attr_accessible :value, :user
  after_create :count_reputation  
  
  belongs_to :user
  belongs_to :votable, :polymorphic => true
  
  validates_inclusion_of :value, :in => [true, false]
  validates :votable, :presence => true
  
  scope :upvotes,      where(:value => true)
  scope :downvotes,    where(:value => false)

  private
  
  def count_reputation
    score = self.votable.votes.upvotes.count - self.votable.votes.downvotes.count
    self.votable.update_attributes(:reputation => score)
  end
end