class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details, dependent: :nullify
  has_many :orders, through: :order_detail
  validates :productname, presence: true
  validates :productcontent, presence: true
  validate  :image_size
  validates :price, presence: true, numericality: true
  validates :discount, numericality: true
  validates :onhand, numericality: true
  validates :status, presence: true
  validates :author, presence: true
  before_update :raise_rollback!
  scope :order_by_created, ->{order(created_at: :desc)}
  scope :by_status, ->(status){where(status: status)}
  scope :by_product_id, ->(product_ids){where(id: product_ids)}
  enum status: {hide: 0, show: 1}
  delegate :title, to: :category, prefix: true, allow_nil: true
  mount_uploader :image, PictureUploader

  def image_size
    return if image.size <= Settings.pic_size.megabytes
    errors.add(:image, t("model.user.pic_less_5"))
  end

  private

  def raise_rollback!
    raise ActiveRecord::Rollback if category.destroy.errors
  end
end
