require 'test_helper'

class PaymentLogEntriesControllerTest < ActionController::TestCase
  setup do
    @payment_log_entry = payment_log_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payment_log_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payment_log_entry" do
    assert_difference('PaymentLogEntry.count') do
      post :create, :payment_log_entry => @payment_log_entry.attributes
    end

    assert_redirected_to payment_log_entry_path(assigns(:payment_log_entry))
  end

  test "should show payment_log_entry" do
    get :show, :id => @payment_log_entry.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @payment_log_entry.to_param
    assert_response :success
  end

  test "should update payment_log_entry" do
    put :update, :id => @payment_log_entry.to_param, :payment_log_entry => @payment_log_entry.attributes
    assert_redirected_to payment_log_entry_path(assigns(:payment_log_entry))
  end

  test "should destroy payment_log_entry" do
    assert_difference('PaymentLogEntry.count', -1) do
      delete :destroy, :id => @payment_log_entry.to_param
    end

    assert_redirected_to payment_log_entries_path
  end
end
