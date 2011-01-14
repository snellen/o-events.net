require 'test_helper'

class CategoryGroupsControllerTest < ActionController::TestCase
  setup do
    @category_group = category_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:category_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category_group" do
    assert_difference('CategoryGroup.count') do
      post :create, :category_group => @category_group.attributes
    end

    assert_redirected_to category_group_path(assigns(:category_group))
  end

  test "should show category_group" do
    get :show, :id => @category_group.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @category_group.to_param
    assert_response :success
  end

  test "should update category_group" do
    put :update, :id => @category_group.to_param, :category_group => @category_group.attributes
    assert_redirected_to category_group_path(assigns(:category_group))
  end

  test "should destroy category_group" do
    assert_difference('CategoryGroup.count', -1) do
      delete :destroy, :id => @category_group.to_param
    end

    assert_redirected_to category_groups_path
  end
end
