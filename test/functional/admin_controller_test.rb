require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get raw_results" do
    get :raw_results
    assert_response :success
  end

  test "should get irv_calc" do
    get :irv_calc
    assert_response :success
  end

  test "should get poll_calc" do
    get :poll_calc
    assert_response :success
  end

end
