require 'test_helper'

class ClubsControllerTest < ActionController::TestCase
  setup do
    @club = clubs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clubs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create club" do
    assert_difference('Club.count') do
      post :create, :club => @club.attributes
    end

    assert_redirected_to club_path(assigns(:club))
  end

  test "should show club" do
    get :show, :id => @club.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @club.to_param
    assert_response :success
  end

  test "should update club" do
    put :update, :id => @club.to_param, :club => @club.attributes
    assert_redirected_to club_path(assigns(:club))
  end

  test "should destroy club" do
    assert_difference('Club.count', -1) do
      delete :destroy, :id => @club.to_param
    end

    assert_redirected_to clubs_path
  end
end
