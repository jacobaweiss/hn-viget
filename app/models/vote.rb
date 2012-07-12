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
    score = votable.votes.upvotes.count - votable.votes.downvotes.count
    votable.update_attributes(:reputation => score)
  end
end