require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should not get search_tag" do
    get :search_tag
    assert_response :bad_request
  end

  test "should post search_tag bad_request" do
    post :search_tag
    assert_response :bad_request
  end

end
