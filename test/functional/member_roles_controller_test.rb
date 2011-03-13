require 'test_helper'

class MemberRolesControllerTest < ActionController::TestCase
  setup do
    @member_role = member_roles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:member_roles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create member_role" do
    assert_difference('MemberRole.count') do
      post :create, :member_role => @member_role.attributes
    end

    assert_redirected_to member_role_path(assigns(:member_role))
  end

  test "should show member_role" do
    get :show, :id => @member_role.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @member_role.to_param
    assert_response :success
  end

  test "should update member_role" do
    put :update, :id => @member_role.to_param, :member_role => @member_role.attributes
    assert_redirected_to member_role_path(assigns(:member_role))
  end

  test "should destroy member_role" do
    assert_difference('MemberRole.count', -1) do
      delete :destroy, :id => @member_role.to_param
    end

    assert_redirected_to member_roles_path
  end
end
