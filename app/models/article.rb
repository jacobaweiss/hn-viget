class Article < ActiveRecord::Base
  attr_accessible :text, :title, :url, :reputation
  
  belongs_to :user
  has_many :comments, :as => :commentable,  dependent: :destroy, :order => 'reputation DESC'
  has_many :votes,    :as => :votable,      dependent: :destroy
  
  validates :title, :presence => true
  validate :text_or_url_are_present

  scope :top_for, lambda {|duration|
    case duration
      when "top"
        order("reputation DESC")
      when "day"
        where("created_at >= ?", 1.day.ago).order("reputation DESC")
      when "month"
        where("created_at >= ?", 1.month.ago).order("reputation DESC")
      when "year"
        where("created_at >= ?", 1.year.ago).order("reputation DESC")
      else
        order("created_at DESC")
    end
  }
  
  private
  
  def text_or_url_are_present
    if text.blank? && url.blank?
      errors.add(:article, "text or url must be present")
    end
  end
  
end
