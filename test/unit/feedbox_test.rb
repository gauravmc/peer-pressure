require 'test_helper'

class FeedboxTest < ActiveSupport::TestCase
  test "load default feedbox colors only if it's a new record" do
    feedbox = feedboxes(:one)
    feedboxes(:one).save
    assert_not_equal 'f5f5f5', feedbox.reload.box_background
  end
end
