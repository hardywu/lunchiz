class ReviewSerializer
  include FastJsonapi::ObjectSerializer
  belongs_to :user
  belongs_to :store
  attributes :rate, :comment, :reply, :date
end
