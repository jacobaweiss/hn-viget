require 'spec_helper'

describe Vote do
  let!(:user) { Factory(:user) }
  let!(:article) { Factory(:article) }
  let(:vote) { Factory(:vote, :user => user, :votable => article, :value => false) }
  
  describe "validations" do
    it { should belong_to(:user) }
    it { should belong_to(:votable) }
    it { should validate_presence_of(:votable) }
    
    it "should require a vote value" do
      vote.value.should_not be_nil
    end
  end  
  
end
