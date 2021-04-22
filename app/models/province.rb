class Province < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :orders, dependent: :destory
end
