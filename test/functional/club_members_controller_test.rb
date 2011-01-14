require 'test_helper'

class ClubMembersControllerTest < ActionController::TestCase
  setup do
    @club_member = club_members(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:club_members)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create club_member" do
    assert_difference('ClubMember.count') do
      post :create, :club_member => @club_member.attributes
    end

    assert_redirected_to club_member_path(assigns(:club_member))
  end

  test "should show club_member" do
    get :show, :id => @club_member.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @club_member.to_param
    assert_response :success
  end

  test "should update club_member" do
    put :update, :id => @club_member.to_param, :club_member => @club_member.attributes
    assert_redirected_to club_member_path(assigns(:club_member))
  end

  test "should destroy club_member" do
    assert_difference('ClubMember.count', -1) do
      delete :destroy, :id => @club_member.to_param
    end

    assert_redirected_to club_members_path
  end
end
