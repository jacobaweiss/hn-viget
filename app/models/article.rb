class Article < ActiveRecord::Base
  attr_accessible :text, :title, :url
  
  belongs_to :user
  has_many :comments, :as => :commentable
  has_many :votes,    :as => :votable, dependent: :destroy
  
  validates :title, :presence => true
  validate :text_or_url_are_present
  
  scope :chronological,  order("created_at DESC")
  
  private
  
  def text_or_url_are_present
    if text.blank? && url.blank?
      errors.add(:article, "text or url must be present")
    end
  end
  
end
