class User < ApplicationRecord
  has_many :notifications
  validates_presence_of :name, :email
end
