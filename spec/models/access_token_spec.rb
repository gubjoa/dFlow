require 'rails_helper'

RSpec.describe AccessToken, :type => :model do
  before :each do
    # Load user with username "admin" and password "admin"
    User.create_missing_users_from_file("#{Rails.root}/spec/support/test-passwd-first")
    @user = User.find_by_username("admin")
  end

  describe "create token" do
    it "should save a proper token" do
      at = AccessToken.new(user_id: @user.id, token: SecureRandom.hex, token_expire: Time.now+1.day)
      expect(at.save).to be_truthy
    end

    it "should require user_id" do
      at = AccessToken.new(token: SecureRandom.hex, token_expire: Time.now+1.day)
      expect(at.save).to be_falsey
    end
  end
end