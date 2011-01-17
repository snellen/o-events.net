require 'test_helper'

class StartBlocksControllerTest < ActionController::TestCase
  setup do
    @start_block = start_blocks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:start_blocks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create start_block" do
    assert_difference('StartBlock.count') do
      post :create, :start_block => @start_block.attributes
    end

    assert_redirected_to start_block_path(assigns(:start_block))
  end

  test "should show start_block" do
    get :show, :id => @start_block.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @start_block.to_param
    assert_response :success
  end

  test "should update start_block" do
    put :update, :id => @start_block.to_param, :start_block => @start_block.attributes
    assert_redirected_to start_block_path(assigns(:start_block))
  end

  test "should destroy start_block" do
    assert_difference('StartBlock.count', -1) do
      delete :destroy, :id => @start_block.to_param
    end

    assert_redirected_to start_blocks_path
  end
end
