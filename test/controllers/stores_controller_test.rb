require 'test_helper'

class StoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @store = stores(:one)
    @user = users(:one)
    @admin = users(:admin)
    @owner = users(:owner)
  end

  test "should get index order by rate average" do
    get '/stores', as: :json
    assert_response :success
    assert_match '"total":3', @response.body
    rates = @response.body.scan(/\"rateAvg\":\"([\d\.]+)/).flatten
    assert_equal 3, rates.size
    assert rates[0] >= rates[1]
  end

  test "should query by owner id" do
    get "/stores?ownerId=#{@owner.id}", as: :json
    assert_response :success
    assert_match @owner.stores[0].name, @response.body
    assert_match '"total":2', @response.body
  end

  test "should query with min and max avg rate range" do
    get '/stores?minRate=2&maxRate=4', as: :json
    assert_response :success
    assert_match '"total":1', @response.body
    rates = @response.body.scan(/\"rateAvg\":\"([\d\.]+)/).flatten
    assert_equal 1, rates.size
    assert rates[0].to_f >= 2
    assert rates[0].to_f <= 4
  end

  test "non-owner should not create store" do
    assert_difference('Store.count', 0) do
      post '/stores',
           params: { data: { attributes: { name: 'sample restaurant' } } },
           as: :json, headers: token_header(@user)
    end

    assert_response 401
  end

  test "owner should create store" do
    assert_difference('Store.count') do
      post '/stores',
           params: { data: { attributes: { name: 'sample restaurant' }}},
           as: :json, headers: token_header(users(:owner_without_rest))
    end

    assert_response 201
  end

  test "should show store" do
    get "/stores/#{@store.id}", as: :json
    assert_response :success
  end

  test "admin should update store" do
    patch "/stores/#{@store.id}", params: { name: 'updated name' },
                                  as: :json, headers: token_header(@admin)
    assert_response 200
  end

  test "non-admin should not update store" do
    patch "/stores/#{@store.id}", params: { name: 'updated name' },
                                  as: :json, headers: token_header(@owner)
    assert_response 401
  end

  test "admin should destroy store" do
    assert_difference('Store.count', -1) do
      delete "/stores/#{@store.id}", as: :json, headers: token_header(@admin)
    end

    assert_response 204
  end

  test "non-admin should not destroy store" do
    assert_difference('Store.count', 0) do
      delete "/stores/#{@store.id}", as: :json, headers: token_header(@owner)
    end

    assert_response 401
  end
end
