require 'spec_helper'

describe Article do
  it { should validate_presence_of(:title) }
  
  it "requires presence of text or url" do
    @article = Factory.build(:article, :text => nil, :url => nil)
    @article.valid?.should == false
  end
  
  it "is valid if only url is present" do
    @article = Factory.build(:article, :text => nil, :url => 'foo')
    @article.valid?.should == true
  end
  
  it "is valid if only text is present" do
    @article = Factory.build(:article, :text => 'nil', :url => nil)
    @article.valid?.should == true
  end
end
