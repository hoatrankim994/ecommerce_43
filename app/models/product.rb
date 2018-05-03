class Product < ApplicationRecord
  belongs_to :category
  has_many :order_detail, dependent: :destroy
  has_many :orders, through: :order_detail
  mount_uploader :image, PictureUploader
  validates :productname, presence: true
  validates :productcontent, presence: true
  validate  :image_size
  validates :price, presence: true, numericality: true
  validates :discount, numericality: true
  validates :onhand, numericality: true
  validates :status, presence: true
  validates :author, presence: true
  enum status: {hide: 0, show: 1}
  scope :order_by_created, ->{order(created_at: :desc)}
  scope :by_status, -> status { where(status: status) }
  def image_size
    return if image.size <= Settings.pic_size.megabytes
    errors.add(:image, t("model.user.pic_less_5"))
  end
end
