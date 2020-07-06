class User < ApplicationRecord
  has_one_attached :image
  has_many :posts, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships,
           class_name: 'Relationship',
           foreign_key: 'follow_id',
           dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user

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

  # Follow a user
  def follow(other_user)
    relationships.create(follow_id: other_user.id) unless self == other_user
  end

  # Unfollow a user
  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship&.destroy
  end

  # Return a true if follow a given user
  def following?(other_user)
    followings.include?(other_user)
  end
end
