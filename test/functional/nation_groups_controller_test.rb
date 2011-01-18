require 'test_helper'

class NationGroupsControllerTest < ActionController::TestCase
  setup do
    @nation_group = nation_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nation_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nation_group" do
    assert_difference('NationGroup.count') do
      post :create, :nation_group => @nation_group.attributes
    end

    assert_redirected_to nation_group_path(assigns(:nation_group))
  end

  test "should show nation_group" do
    get :show, :id => @nation_group.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @nation_group.to_param
    assert_response :success
  end

  test "should update nation_group" do
    put :update, :id => @nation_group.to_param, :nation_group => @nation_group.attributes
    assert_redirected_to nation_group_path(assigns(:nation_group))
  end

  test "should destroy nation_group" do
    assert_difference('NationGroup.count', -1) do
      delete :destroy, :id => @nation_group.to_param
    end

    assert_redirected_to nation_groups_path
  end
end
