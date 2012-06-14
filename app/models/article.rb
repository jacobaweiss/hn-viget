class Article < ActiveRecord::Base
  attr_accessible :text, :title, :url
  
  validates :title, :presence => true
  validate :text_or_url_are_present
  
  def text_or_url_are_present
    if text.blank? && url.blank?
      errors.add(:double_blank, "Either text or url must be present")
    end
  end
  
end
