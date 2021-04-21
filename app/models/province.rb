class Province < ApplicationRecord
  has_many :users, dependent: :destory
end
