class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :url, presence: true, length: { maximum: 11 }
  validates :content, length: { maximum: 800 }
end
