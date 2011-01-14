require 'test_helper'

class SplitTimesControllerTest < ActionController::TestCase
  setup do
    @split_time = split_times(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:split_times)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create split_time" do
    assert_difference('SplitTime.count') do
      post :create, :split_time => @split_time.attributes
    end

    assert_redirected_to split_time_path(assigns(:split_time))
  end

  test "should show split_time" do
    get :show, :id => @split_time.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @split_time.to_param
    assert_response :success
  end

  test "should update split_time" do
    put :update, :id => @split_time.to_param, :split_time => @split_time.attributes
    assert_redirected_to split_time_path(assigns(:split_time))
  end

  test "should destroy split_time" do
    assert_difference('SplitTime.count', -1) do
      delete :destroy, :id => @split_time.to_param
    end

    assert_redirected_to split_times_path
  end
end
