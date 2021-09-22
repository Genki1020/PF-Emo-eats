class Emo < ApplicationRecord
  has_many :eateries, dependent: :destroy
end