require 'test_helper'

class StartTimesControllerTest < ActionController::TestCase
  setup do
    @start_time = start_times(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:start_times)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create start_time" do
    assert_difference('StartTime.count') do
      post :create, :start_time => @start_time.attributes
    end

    assert_redirected_to start_time_path(assigns(:start_time))
  end

  test "should show start_time" do
    get :show, :id => @start_time.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @start_time.to_param
    assert_response :success
  end

  test "should update start_time" do
    put :update, :id => @start_time.to_param, :start_time => @start_time.attributes
    assert_redirected_to start_time_path(assigns(:start_time))
  end

  test "should destroy start_time" do
    assert_difference('StartTime.count', -1) do
      delete :destroy, :id => @start_time.to_param
    end

    assert_redirected_to start_times_path
  end
end
