class Book < ApplicationRecord
  paginates_per 9
  belongs_to :genre

  has_many :ordered_books, dependent: :destroy
  has_many :orders, through: :ordered_books

  validates :title, :price, :author, :publisher, presence: true
  validates :price, numericality: true
  has_one_attached :image
end
