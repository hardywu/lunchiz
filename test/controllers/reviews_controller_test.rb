require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @review = reviews(:one)
    @user = users(:one)
    @admin = users(:admin)
    @owner = users(:owner)
  end

  test "should get index" do
    get '/reviews', as: :json
    assert_response :success
    assert_match '"total":2', @response.body
  end

  test "non-user should not create review" do
    assert_difference('Review.count', 0) do
      attrs = { rate: 4, date: '2018-10-11', comment: 'ok' }
      post '/reviews', params: { data: { attributes: attrs } },
                       as: :json, headers: token_header(@owner)
    end

    assert_response 401
  end

  test "user should create review" do
    assert_difference('Review.count') do
      attrs = { rate: 4, date: '2018-10-11', comment: 'ok' }
      relat = { store: { data: { id: stores(:one).id } } }
      post '/reviews', params: {
        data: { attributes: attrs, relationships: relat }
      }, as: :json, headers: token_header(@user)
    end

    assert_response 201
  end

  test "should show review" do
    get "/reviews/#{@review.id}", as: :json
    assert_response :success
  end

  test "admin should update review" do
    patch "/reviews/#{@review.id}", params: { comment: 'updated' },
                                    as: :json, headers: token_header(@admin)
    assert_response 200
  end

  test "owner should reply review" do
    patch "/reviews/#{@review.id}/reply", params: {
      data: { attributes: { reply: 'updated new replys' } }
    }, as: :json, headers: token_header(@owner)

    assert_response 200
    assert_match 'updated new replys', @response.body
  end

  test "non-admin should not update review" do
    patch "/reviews/#{@review.id}", params: { comment: 'updated' },
                                    as: :json, headers: token_header(@owner)
    assert_response 401
  end

  test "admin should destroy review" do
    assert_difference('Review.count', -1) do
      delete "/reviews/#{@review.id}", as: :json, headers: token_header(@admin)
    end

    assert_response 204
  end

  test "non-admin should not destroy review" do
    assert_difference('Review.count', 0) do
      delete "/reviews/#{@review.id}", as: :json, headers: token_header(@owner)
    end

    assert_response 401
  end
end
