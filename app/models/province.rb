class Province < ApplicationRecord
  has_many :users, dependent: :destroy
end
