class Message < ApplicationRecord
  validates :body, presence: true, length: {minimum:0, maximum:250}
  belongs_to :user
end
