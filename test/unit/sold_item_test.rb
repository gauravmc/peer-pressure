require 'test_helper'

class SoldItemTest < ActiveSupport::TestCase
  require 'test_helper'

  class SoldItemTest < ActiveSupport::TestCase
    setup do
      @order_create_data = load_json('order_create.json')
    end

    test "new sold items get saved form the webhook json data" do
      assert_difference 'SoldItem.count', 2 do
        SoldItem.fetch_new_items_from(@order_create_data)
      end
    end
  end
end
