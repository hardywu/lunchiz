class Store < ApplicationRecord
  belongs_to :owner, class_name: 'Owner'
  validates :owner_id, uniqueness: true
  validates :name, presence: true
end
