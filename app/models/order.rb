class Order < ApplicationRecord
  belongs_to :user

  validates :username, :email_confirmation, presence: true
  validates :phone, numericality: true
end
