class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_one :giftcode, dependent: :destroy
  enum role: {admin: 0, user: 1, customer: 2}
end
