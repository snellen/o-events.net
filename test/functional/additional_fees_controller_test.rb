require 'test_helper'

class AdditionalFeesControllerTest < ActionController::TestCase
  setup do
    @additional_fee = additional_fees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:additional_fees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create additional_fee" do
    assert_difference('AdditionalFee.count') do
      post :create, :additional_fee => @additional_fee.attributes
    end

    assert_redirected_to additional_fee_path(assigns(:additional_fee))
  end

  test "should show additional_fee" do
    get :show, :id => @additional_fee.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @additional_fee.to_param
    assert_response :success
  end

  test "should update additional_fee" do
    put :update, :id => @additional_fee.to_param, :additional_fee => @additional_fee.attributes
    assert_redirected_to additional_fee_path(assigns(:additional_fee))
  end

  test "should destroy additional_fee" do
    assert_difference('AdditionalFee.count', -1) do
      delete :destroy, :id => @additional_fee.to_param
    end

    assert_redirected_to additional_fees_path
  end
end
