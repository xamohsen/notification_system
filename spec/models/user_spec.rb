require 'rails_helper'

RSpec.describe User, type: :model do
  subject {described_class.new(name: 'test user', email: 'email@email.email')}
  it "should be valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "should not be valid without name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  it "should not be valid without email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:email)}
  describe "Associations" do
    it.skip {should have_many(:notification)}
  end
end
