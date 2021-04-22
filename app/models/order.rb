class Order < ApplicationRecord
  belongs_to :user

  has_many :ordered_books, dependent: :destroy
  has_many :books, through: :ordered_books

  validates :username, :email_confirmation, presence: true
end
