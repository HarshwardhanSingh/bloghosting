require 'test_helper'

class AddPopularityToPostsControllerTest < ActionController::TestCase
  test "should get popularity:integer" do
    get :popularity:integer
    assert_response :success
  end

end
