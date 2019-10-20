class StoreSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  belongs_to :owner
end
