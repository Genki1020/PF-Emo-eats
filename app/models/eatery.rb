class Eatery < ApplicationRecord
  belongs_to :user
  belongs_to :emo
  has_many_attached :images
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
geocoded_by :address
after_validation :geocode, if: Proc.new { |a| a.address_changed? }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
