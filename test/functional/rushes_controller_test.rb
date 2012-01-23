require 'test_helper'

class RushesControllerTest < ActionController::TestCase
  setup do
    @rush = rushes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rushes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rush" do
    assert_difference('Rush.count') do
      post :create, :rush => @rush.attributes
    end

    assert_redirected_to rush_path(assigns(:rush))
  end

  test "should show rush" do
    get :show, :id => @rush.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @rush.to_param
    assert_response :success
  end

  test "should update rush" do
    put :update, :id => @rush.to_param, :rush => @rush.attributes
    assert_redirected_to rush_path(assigns(:rush))
  end

  test "should destroy rush" do
    assert_difference('Rush.count', -1) do
      delete :destroy, :id => @rush.to_param
    end

    assert_redirected_to rushes_path
  end
end
