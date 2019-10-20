class StoreSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :rate_avg
  belongs_to :owner
end
