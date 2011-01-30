require 'test_helper'

class EventSettingsControllerTest < ActionController::TestCase
  setup do
    @event_setting = event_settings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_settings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event_setting" do
    assert_difference('EventSetting.count') do
      post :create, :event_setting => @event_setting.attributes
    end

    assert_redirected_to event_setting_path(assigns(:event_setting))
  end

  test "should show event_setting" do
    get :show, :id => @event_setting.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @event_setting.to_param
    assert_response :success
  end

  test "should update event_setting" do
    put :update, :id => @event_setting.to_param, :event_setting => @event_setting.attributes
    assert_redirected_to event_setting_path(assigns(:event_setting))
  end

  test "should destroy event_setting" do
    assert_difference('EventSetting.count', -1) do
      delete :destroy, :id => @event_setting.to_param
    end

    assert_redirected_to event_settings_path
  end
end
