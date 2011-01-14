require 'test_helper'

class CurrenciesControllerTest < ActionController::TestCase
  setup do
    @currency = currencies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:currencies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create currency" do
    assert_difference('Currency.count') do
      post :create, :currency => @currency.attributes
    end

    assert_redirected_to currency_path(assigns(:currency))
  end

  test "should show currency" do
    get :show, :id => @currency.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @currency.to_param
    assert_response :success
  end

  test "should update currency" do
    put :update, :id => @currency.to_param, :currency => @currency.attributes
    assert_redirected_to currency_path(assigns(:currency))
  end

  test "should destroy currency" do
    assert_difference('Currency.count', -1) do
      delete :destroy, :id => @currency.to_param
    end

    assert_redirected_to currencies_path
  end
end
