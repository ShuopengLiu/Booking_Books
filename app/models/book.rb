class Book < ApplicationRecord
  belongs_to :genre
  validates :title, :price, presence: true
  has_one_attached :image
end
