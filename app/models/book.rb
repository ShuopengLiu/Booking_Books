class Book < ApplicationRecord
  belongs_to :genre

  has_many :ordered_books
  has_many :orders, through: :ordered_books

  validates :title, :price, :author, :publisher, presence: true
  validates :price, numericality: true
  has_one_attached :image
end
