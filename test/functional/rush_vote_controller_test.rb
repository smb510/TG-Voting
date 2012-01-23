require 'test_helper'

class RushVoteControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get vote" do
    get :vote
    assert_response :success
  end

  test "should get tally" do
    get :tally
    assert_response :success
  end

end
