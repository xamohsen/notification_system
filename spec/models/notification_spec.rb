require 'rails_helper'

RSpec.describe Notification, type: :model do
  it "should be valid with valid attributes" do
    message = create :message
    user = create :user
    expect(build :notification, user_id: user[:id], message_id: message[:id]).to be_valid
  end
  it "should be not valid without user_id" do
    message = create :message
    expect(build :notification, message_id: message[:id]).to_not be_valid
  end
  it "should be not valid without message_id" do
    user = create :user
    expect(build :notification, user_id: user[:id]).to_not be_valid
  end
  after :all do
    Notification.delete_all
    User.delete_all
    Message.delete_all
  end

  describe "ActiveRecord associations" do
    it {should belong_to(:user)}
    it {should belong_to(:message)}
  end

end
