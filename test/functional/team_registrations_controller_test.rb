require 'test_helper'

class TeamRegistrationsControllerTest < ActionController::TestCase
  setup do
    @team_registration = team_registrations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:team_registrations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create team_registration" do
    assert_difference('TeamRegistration.count') do
      post :create, :team_registration => @team_registration.attributes
    end

    assert_redirected_to team_registration_path(assigns(:team_registration))
  end

  test "should show team_registration" do
    get :show, :id => @team_registration.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @team_registration.to_param
    assert_response :success
  end

  test "should update team_registration" do
    put :update, :id => @team_registration.to_param, :team_registration => @team_registration.attributes
    assert_redirected_to team_registration_path(assigns(:team_registration))
  end

  test "should destroy team_registration" do
    assert_difference('TeamRegistration.count', -1) do
      delete :destroy, :id => @team_registration.to_param
    end

    assert_redirected_to team_registrations_path
  end
end
