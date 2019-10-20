require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should register user" do
    assert_difference('User.count') do
      post '/auth/signup',
           params: { email: 'sample@test.com', password: 'changeme' },
           as: :json
    end

    assert_response 201
  end

  test "should login user" do
    post '/auth/signin',
         params: { email: 'sample@test.com', password: 'changeme' },
         as: :json

    assert_response 201
  end
end
