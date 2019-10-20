class Review < ApplicationRecord
  belongs_to :user
  belongs_to :store
  validates :rate,
            numericality: {
              only_integer: true, greater_than: 0, less_than: 6
            }
  validates :comment, presence: true
end
