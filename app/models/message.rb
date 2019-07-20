class Message < ApplicationRecord
  translates :body, :title
  validates_presence_of :title, presence: true

end
