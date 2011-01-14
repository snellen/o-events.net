require 'test_helper'

class ChipsControllerTest < ActionController::TestCase
  setup do
    @chip = chips(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create chip" do
    assert_difference('Chip.count') do
      post :create, :chip => @chip.attributes
    end

    assert_redirected_to chip_path(assigns(:chip))
  end

  test "should show chip" do
    get :show, :id => @chip.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @chip.to_param
    assert_response :success
  end

  test "should update chip" do
    put :update, :id => @chip.to_param, :chip => @chip.attributes
    assert_redirected_to chip_path(assigns(:chip))
  end

  test "should destroy chip" do
    assert_difference('Chip.count', -1) do
      delete :destroy, :id => @chip.to_param
    end

    assert_redirected_to chips_path
  end
end
