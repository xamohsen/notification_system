class Message < ApplicationRecord
  has_many :notifications
  translates :body, :title
  validates_presence_of :title, presence: true
end
