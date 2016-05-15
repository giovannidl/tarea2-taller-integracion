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

  test "should post search_tag" do
    post(:search_tag, {tag: 'santiago', access_token: '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402'})
    assert_response :ok
  end

end
