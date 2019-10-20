class Store < ApplicationRecord
  belongs_to :owner, class_name: 'Owner'
  has_many :reviews
  validates :owner_id, uniqueness: true
  validates :name, presence: true
end
