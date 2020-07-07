class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  validates :url, presence: true, length: { maximum: 11 }
  validates :content, length: { maximum: 800 }
end
