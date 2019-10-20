require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @admin = users(:admin)
  end

  test "admin should get index" do
    get 'users', as: :json, headers: token_header(@admin)
    assert_response :success
  end

  test "admin should show user" do
    get "users/#{@user.id}", as: :json, headers: token_header(@admin)
    assert_response :success
  end

  test "admin should update user" do
    patch "users/#{@user.id}", params: { email: 'change@test.com' },
          as: :json, headers: token_header(@admin)
    assert_response 200
  end

  test "admin should destroy user" do
    assert_difference('User.count', -1) do
      delete "users/#{@user.id}", as: :json, headers: token_header(@admin)
    end

    assert_response 204
  end
end
