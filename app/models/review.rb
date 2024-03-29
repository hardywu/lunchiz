class Review < ApplicationRecord
  belongs_to :user
  belongs_to :store, counter_cache: true
  scope :latest, -> { order(created_at: :desc) }
  scope :lowest, -> { order(rate: :asc) }
  scope :highest, -> { order(rate: :desc) }
  validates :rate,
            numericality: {
              only_integer: true, greater_than: 0, less_than: 6
            }
  validates :comment, presence: true
  validates :store_id, uniqueness: { scope: :user_id }
  after_create :update_store_rate_stats

  def update_store_rate_stats
    store.update rate_sum: store.rate_sum + rate,
                 rate_avg: (store.rate_sum + rate).to_f / store.reviews_count
  end
end
