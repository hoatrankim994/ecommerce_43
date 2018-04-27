class User < ApplicationRecord
  attr_accessor :remember_token
  before_save{self.email = email.downcase}
  mount_uploader :avartar, PictureUploader
  has_many :orders, dependent: :destroy
  has_one :giftcode, dependent: :destroy
  enum role: {admin: 0, user: 1, customer: 2}
  validates :name, presence: true, length: {maximum: Settings.leng_name_max}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.leng_email_max}, format: {with: VALID_EMAIL_REGEX},
   uniqueness: true
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.leng_pass_min}, allow_nil: true
  validates :phone, presence: true, numericality: true, length: {maximum: Settings.leng_phone_max}
  validates :address, presence: true, length: {maximum: Settings.leng_address_max}
  validates :gender, presence: true
  validate  :picture_size

  def self.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update(remember_digest: User.digest(remember_token))
  end

  def authenticated? remember_token
    return false if remember_digest.blank?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update(remember_digest: nil)
  end

  def picture_size
    return if avartar.size <= Settings.pic_size.megabytes
    errors.add(:avartar, t("pic_less_5"))
  end
end
