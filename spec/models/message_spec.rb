require 'rails_helper'

RSpec.describe Message, type: :model do
  subject {described_class.new(icon: 'test icon', link_to: 'link to hill', title: "title", body: "body")}

  it "should be valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "should be valid without link_to" do
    subject.link_to = nil
    expect(subject).to be_valid
  end
  it "should be valid without icon" do
    subject.icon = nil
    expect(subject).to be_valid
  end
  it "should be valid without body" do
    subject.body = nil
    expect(subject).to be_valid
  end
  it "should be not valid without title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  describe "ActiveRecord associations" do
    it {should have_many(:notifications)}
  end

end
