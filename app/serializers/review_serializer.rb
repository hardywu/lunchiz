class ReviewSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  belongs_to :user
  belongs_to :store
  attributes :rate, :comment, :reply, :date
end
