require 'test_helper'

class RegistrationDeadlinesControllerTest < ActionController::TestCase
  setup do
    @registration_deadline = registration_deadlines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:registration_deadlines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create registration_deadline" do
    assert_difference('RegistrationDeadline.count') do
      post :create, :registration_deadline => @registration_deadline.attributes
    end

    assert_redirected_to registration_deadline_path(assigns(:registration_deadline))
  end

  test "should show registration_deadline" do
    get :show, :id => @registration_deadline.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @registration_deadline.to_param
    assert_response :success
  end

  test "should update registration_deadline" do
    put :update, :id => @registration_deadline.to_param, :registration_deadline => @registration_deadline.attributes
    assert_redirected_to registration_deadline_path(assigns(:registration_deadline))
  end

  test "should destroy registration_deadline" do
    assert_difference('RegistrationDeadline.count', -1) do
      delete :destroy, :id => @registration_deadline.to_param
    end

    assert_redirected_to registration_deadlines_path
  end
end
