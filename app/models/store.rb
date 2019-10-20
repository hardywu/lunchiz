class Store < ApplicationRecord
  validates :user_id, uniqueness: true
end
