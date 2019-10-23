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

    assert_response :created
    assert_match(/.+\..+\..+/, @response.headers['Authorization'])
  end

  test "should register owner" do
    assert_difference('Owner.count') do
      post '/auth/signup', params: {
        email: 'sample@test.com', password: 'changeme', type: 'owner'
      }, as: :json
    end

    assert_response :created
  end

  test "should login user" do
    post '/auth/signin',
         params: { email: @user.email, password: 'changeme' },
         as: :json

    assert_response :ok
    assert_match(/.+\..+\..+/, @response.headers['Authorization'])
  end

  test "shold failed login user" do
    post '/auth/signin',
         params: { email: @user.email, password: 'wrong' },
         as: :json

    assert_response 401
  end

  test "should get user himself" do
    get '/auth/me', as: :json, headers: token_header(@user)

    assert_response :ok
    assert_match "\"email\":\"#{@user.email}\"", @response.body
  end
end
