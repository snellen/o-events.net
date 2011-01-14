require 'test_helper'

class CompetingClubsControllerTest < ActionController::TestCase
  setup do
    @competing_club = competing_clubs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:competing_clubs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create competing_club" do
    assert_difference('CompetingClub.count') do
      post :create, :competing_club => @competing_club.attributes
    end

    assert_redirected_to competing_club_path(assigns(:competing_club))
  end

  test "should show competing_club" do
    get :show, :id => @competing_club.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @competing_club.to_param
    assert_response :success
  end

  test "should update competing_club" do
    put :update, :id => @competing_club.to_param, :competing_club => @competing_club.attributes
    assert_redirected_to competing_club_path(assigns(:competing_club))
  end

  test "should destroy competing_club" do
    assert_difference('CompetingClub.count', -1) do
      delete :destroy, :id => @competing_club.to_param
    end

    assert_redirected_to competing_clubs_path
  end
end
