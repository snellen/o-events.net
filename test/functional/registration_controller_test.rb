require 'test_helper'

class RegistrationControllerTest < ActionController::TestCase
  test "should get overview" do
    get :overview
    assert_response :success
  end

  test "should get main" do
    get :main
    assert_response :success
  end

  test "should get team_members" do
    get :team_members
    assert_response :success
  end

  test "should get team_options" do
    get :team_options
    assert_response :success
  end

end
