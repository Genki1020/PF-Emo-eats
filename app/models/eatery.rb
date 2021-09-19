class Eatery < ApplicationRecord
  belongs_to :user
  belongs_to :emo
  has_many_attached :images
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
