class Order < ApplicationRecord
  belongs_to :users
  belongs_to :giftcodes
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details
end
