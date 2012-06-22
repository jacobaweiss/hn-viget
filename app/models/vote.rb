class Vote < ActiveRecord::Base
  attr_accessible :value
  
  belongs_to :user
  belongs_to :votable, :polymorphic => true
  
  validates :value, :presence => :true
  
end