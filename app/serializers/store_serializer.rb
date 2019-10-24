class StoreSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :name, :rate_avg
  belongs_to :owner
  attribute :can_review, if: proc { |_, p| p[:current_user] } do |_, params|
    params[:current_user]&.is_a?(User)
  end
  attribute :my_review_id, if: proc { |_, p| p[:current_user] } do |rec, params|
    Review.find_by(user_id: params[:current_user]&.id, store_id: rec.id)&.id
  end
end
