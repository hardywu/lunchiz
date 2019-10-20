require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "should check the correct password" do
    assert @user&.authenticate('changeme')
  end

  test "should authenticate JWT" do
    user = User.of_jwt @user.jwt
    assert user&.valid?
  end
end
