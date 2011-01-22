require 'test_helper'

class CountryGroupsControllerTest < ActionController::TestCase
  setup do
    @country_group = country_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:country_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create country_group" do
    assert_difference('CountryGroup.count') do
      post :create, :country_group => @country_group.attributes
    end

    assert_redirected_to country_group_path(assigns(:country_group))
  end

  test "should show country_group" do
    get :show, :id => @country_group.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @country_group.to_param
    assert_response :success
  end

  test "should update country_group" do
    put :update, :id => @country_group.to_param, :country_group => @country_group.attributes
    assert_redirected_to country_group_path(assigns(:country_group))
  end

  test "should destroy country_group" do
    assert_difference('CountryGroup.count', -1) do
      delete :destroy, :id => @country_group.to_param
    end

    assert_redirected_to country_groups_path
  end
end
