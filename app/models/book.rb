class Book < ApplicationRecord
  belongs_to :genre
  validates :title, :price, :author, :publisher, presence: true
  validates :price, numericality: true
  has_one_attached :image
end
