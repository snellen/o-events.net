require 'test_helper'

class PostFinanceControllerTest < ActionController::TestCase
  test "should get payment_accepted" do
    get :payment_accepted
    assert_response :success
  end

  test "should get payment_declined" do
    get :payment_declined
    assert_response :success
  end

  test "should get payment_canceled" do
    get :payment_canceled
    assert_response :success
  end

  test "should get payment_exception" do
    get :payment_exception
    assert_response :success
  end

  test "should get post_sale" do
    get :post_sale
    assert_response :success
  end

end
