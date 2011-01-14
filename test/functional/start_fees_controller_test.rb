require 'test_helper'

class StartFeesControllerTest < ActionController::TestCase
  setup do
    @start_fee = start_fees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:start_fees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create start_fee" do
    assert_difference('StartFee.count') do
      post :create, :start_fee => @start_fee.attributes
    end

    assert_redirected_to start_fee_path(assigns(:start_fee))
  end

  test "should show start_fee" do
    get :show, :id => @start_fee.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @start_fee.to_param
    assert_response :success
  end

  test "should update start_fee" do
    put :update, :id => @start_fee.to_param, :start_fee => @start_fee.attributes
    assert_redirected_to start_fee_path(assigns(:start_fee))
  end

  test "should destroy start_fee" do
    assert_difference('StartFee.count', -1) do
      delete :destroy, :id => @start_fee.to_param
    end

    assert_redirected_to start_fees_path
  end
end
