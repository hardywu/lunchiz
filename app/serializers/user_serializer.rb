class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email
  attribute(:role) { |obj| obj.type }
  has_many :stores, if: Proc.new { |record| record.is_a?(Owner) }
end
