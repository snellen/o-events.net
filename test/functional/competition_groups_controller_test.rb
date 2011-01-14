require 'test_helper'

class CompetitionGroupsControllerTest < ActionController::TestCase
  setup do
    @competition_group = competition_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:competition_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create competition_group" do
    assert_difference('CompetitionGroup.count') do
      post :create, :competition_group => @competition_group.attributes
    end

    assert_redirected_to competition_group_path(assigns(:competition_group))
  end

  test "should show competition_group" do
    get :show, :id => @competition_group.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @competition_group.to_param
    assert_response :success
  end

  test "should update competition_group" do
    put :update, :id => @competition_group.to_param, :competition_group => @competition_group.attributes
    assert_redirected_to competition_group_path(assigns(:competition_group))
  end

  test "should destroy competition_group" do
    assert_difference('CompetitionGroup.count', -1) do
      delete :destroy, :id => @competition_group.to_param
    end

    assert_redirected_to competition_groups_path
  end
end
