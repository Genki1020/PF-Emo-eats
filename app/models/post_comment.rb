class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :eatery
  has_many :notifications, dependent: :destroy
end
