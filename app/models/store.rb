class Store < ApplicationRecord
  belongs_to :owner, class_name: 'Owner'
  has_many :reviews
  validates :name, presence: true
  default_scope { order(rate_avg: :desc) }
end
