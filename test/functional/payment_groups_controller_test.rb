require 'test_helper'

class PaymentGroupsControllerTest < ActionController::TestCase
  setup do
    @payment_group = payment_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payment_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payment_group" do
    assert_difference('PaymentGroup.count') do
      post :create, :payment_group => @payment_group.attributes
    end

    assert_redirected_to payment_group_path(assigns(:payment_group))
  end

  test "should show payment_group" do
    get :show, :id => @payment_group.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @payment_group.to_param
    assert_response :success
  end

  test "should update payment_group" do
    put :update, :id => @payment_group.to_param, :payment_group => @payment_group.attributes
    assert_redirected_to payment_group_path(assigns(:payment_group))
  end

  test "should destroy payment_group" do
    assert_difference('PaymentGroup.count', -1) do
      delete :destroy, :id => @payment_group.to_param
    end

    assert_redirected_to payment_groups_path
  end
end
