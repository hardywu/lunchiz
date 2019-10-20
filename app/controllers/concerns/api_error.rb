module ApiError
  extend ActiveSupport::Concern

  class AuthFailed < StandardError; end
  class InvalidParam < StandardError; end
end
