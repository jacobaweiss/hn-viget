class Article < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :text, :title, :url
  
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
