require 'test_helper'

class StoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @store = stores(:one)
    @user = users(:one)
    @admin = users(:admin)
    @owner = users(:owner)
  end

  test "should get index" do
    get 'stores', as: :json
    assert_response :success
  end

  test "non-owner should not create store" do
    assert_difference('Store.count', 0) do
      post 'stores',
           params: { name: "sample restaurant" },
           as: :json, headers: token_head(@user)
    end

    assert_response 401
  end

  test "owner should create store" do
    assert_difference('Store.count') do
      post 'stores',
           params: { name: 'sample restaurant' },
           as: :json, headers: token_head(@owner)
    end

    assert_response 201
  end

  test "should show store" do
    get "stores/#{@store.id}", as: :json
    assert_response :success
  end

  test "admin should update store" do
    patch "stores/#{@store.id}", params: { name: 'updated name' },
                                 as: :json, headers: token_head(@admin)
    assert_response 200
  end

  test "non-admin should not update store" do
    patch "stores/#{@store.id}", params: { name: 'updated name' },
                                 as: :json, headers: token_head(@owner)
    assert_response 401
  end

  test "admin should destroy store" do
    assert_difference('Store.count', -1) do
      delete "stores/#{@store.id}", as: :json, headers: token_head(@admin)
    end

    assert_response 204
  end

  test "non-admin should not destroy store" do
    assert_difference('Store.count', 0) do
      delete "stores/#{@store.id}", as: :json, headers: token_head(@owner)
    end

    assert_response 401
  end
end
