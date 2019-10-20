module ApiError
  extend ActiveSupport::Concern

  class AuthFailed < StandardError; end
end
