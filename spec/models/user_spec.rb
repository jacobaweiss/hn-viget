require 'spec_helper'

describe User do
  
  subject { Factory(:user) }
  
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_confirmation_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
  end

end
