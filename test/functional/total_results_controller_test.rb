require 'test_helper'

class TotalResultsControllerTest < ActionController::TestCase
  setup do
    @total_result = total_results(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:total_results)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create total_result" do
    assert_difference('TotalResult.count') do
      post :create, :total_result => @total_result.attributes
    end

    assert_redirected_to total_result_path(assigns(:total_result))
  end

  test "should show total_result" do
    get :show, :id => @total_result.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @total_result.to_param
    assert_response :success
  end

  test "should update total_result" do
    put :update, :id => @total_result.to_param, :total_result => @total_result.attributes
    assert_redirected_to total_result_path(assigns(:total_result))
  end

  test "should destroy total_result" do
    assert_difference('TotalResult.count', -1) do
      delete :destroy, :id => @total_result.to_param
    end

    assert_redirected_to total_results_path
  end
end
