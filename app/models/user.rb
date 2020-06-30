class User < ApplicationRecord
  has_one_attached :image
  has_many :posts, dependent: :destroy

  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email,
            presence: true,
            length: { maximum: 255 },
            uniqueness: true,
            format: { with: VALID_EMAIL_REGEX }
  has_secure_password validations: false
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }
  validates :image,
            content_type: {
              in: %w[image/jpeg image/png image/gif],
              message: 'は、JPEG、PNG、GIFのいずれかの形式の画像を指定してください'
            },
            size: { less_than: 5.megabytes, message: 'は、5MBより小さいサイズの画像を指定してください' }
end
