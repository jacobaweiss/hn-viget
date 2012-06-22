class Comment < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  has_many   :comments,    :as => :commentable
  has_many   :votes,       :as => :votable, dependent: :destroy
  
  validates :content, :presence => true
  
  def article
    return @article if defined?(@article)
    @article = commentable.is_a?(Article) ? commentable : commentable.article
  end

end
