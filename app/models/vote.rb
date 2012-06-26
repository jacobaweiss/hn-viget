class Vote < ActiveRecord::Base
  attr_accessible :value, :user
  
  belongs_to :user
  belongs_to :votable, :polymorphic => true
  
  validates_inclusion_of :value, :in => [true, false]
end