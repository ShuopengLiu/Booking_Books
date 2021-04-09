class User < ApplicationRecord
  has_many :orders, dependent: :destroy

  # validates :email, confirmation: true
  # validates :username, :email_confirmation, presence: true
  # validates :phone, numericality: true
end
