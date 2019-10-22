class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email
  attribute(:role) { |obj| obj.type }
end
