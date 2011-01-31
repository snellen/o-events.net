require 'test_helper'

class TeamPoolsControllerTest < ActionController::TestCase
  setup do
    @team_pool = team_pools(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:team_pools)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create team_pool" do
    assert_difference('TeamPool.count') do
      post :create, :team_pool => @team_pool.attributes
    end

    assert_redirected_to team_pool_path(assigns(:team_pool))
  end

  test "should show team_pool" do
    get :show, :id => @team_pool.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @team_pool.to_param
    assert_response :success
  end

  test "should update team_pool" do
    put :update, :id => @team_pool.to_param, :team_pool => @team_pool.attributes
    assert_redirected_to team_pool_path(assigns(:team_pool))
  end

  test "should destroy team_pool" do
    assert_difference('TeamPool.count', -1) do
      delete :destroy, :id => @team_pool.to_param
    end

    assert_redirected_to team_pools_path
  end
end
