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
end
