class Product < ApplicationRecord
  belongs_to :categories
  has_many :order_detail, dependent: :destroy
  has_many :orders, through: :order_detail
end
