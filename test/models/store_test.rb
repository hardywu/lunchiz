require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  setup do
    @owner = users(:owner)
    @owner_without_store = users(:owner_without_rest)
  end

  test "should not create one more store" do
    assert_raise do
      @owner.create_store(name: 'new store')
    end
  end

  test "should create one store" do
    store = @owner_without_store.build_store(name: 'new store')
    assert store.save
  end

  test "should have average rate" do
    store = stores(:one)
    user = users(:one)
    store.reviews.create rate: 4, date: '2009-01-01', comment: 'good',
                         user: user
    store.reload
    mean = store.reviews.map(&:rate).sum.to_f / store.reviews.size
    assert_equal store.rate_avg.round(2), mean.round(2)
    assert_equal store.reviews.size, 3
  end
end
