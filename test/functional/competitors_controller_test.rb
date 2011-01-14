require 'test_helper'

class CompetitorsControllerTest < ActionController::TestCase
  setup do
    @competitor = competitors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:competitors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create competitor" do
    assert_difference('Competitor.count') do
      post :create, :competitor => @competitor.attributes
    end

    assert_redirected_to competitor_path(assigns(:competitor))
  end

  test "should show competitor" do
    get :show, :id => @competitor.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @competitor.to_param
    assert_response :success
  end

  test "should update competitor" do
    put :update, :id => @competitor.to_param, :competitor => @competitor.attributes
    assert_redirected_to competitor_path(assigns(:competitor))
  end

  test "should destroy competitor" do
    assert_difference('Competitor.count', -1) do
      delete :destroy, :id => @competitor.to_param
    end

    assert_redirected_to competitors_path
  end
end
