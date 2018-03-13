class User < ApplicationRecord
attr_accessor :remember_token

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 249},
                    format: { with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false}
  has_secure_password
  has_attached_file :image, :default_url => "/assets/missing_large.png"
  has_many :articles
  has_many :relationships
  has_many :followeds, through: :relationships
  validates :password, presence: true, length: { minimum: 6 }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  #check if logged in user follows the person's page they are on
  def following?(user)
    followeds.include?(user)
  end

  #follow the user
  def follow(user)
    followeds << user
  end

  #unfollow the user
  def unfollow(user)
    followeds.delete(user)
  end
  
  #return digest of given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #return random token for cookies
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
