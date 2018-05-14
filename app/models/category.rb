class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  belongs_to :parent, class_name: Category.name, foreign_key: :parent_id, optional: true, inverse_of: :children
  has_many :children, class_name: Category.name, foreign_key: :parent_id, dependent: :nullify, inverse_of: :parent
  validates :catcontent, presence: true
  validates :title, presence: true
  validates :status, presence: true
  scope :by_category, ->(parent_id){where(parent_id: parent_id)}
  scope :ordered_by_title, ->{order(title: :asc)}
  enum status: {hide: 0, show: 1}

  def family_name
    return "" unless parent
    parent.family_name + parent.title + " >> "
  end

  def long_name
    family_name + title
  end
end
