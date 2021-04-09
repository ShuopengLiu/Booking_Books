class OrderedBook < ApplicationRecord
  belongs_to :book
  belongs_to :order

  validates :quantity, :selling_price, presence: true
  validates :quantity, :selling_price, numericality: true
end
