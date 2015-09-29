require 'test_helper'

class ControlsControllerTest < ActionController::TestCase
  setup do
    @control = controls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:controls)
  end

  test "should create control" do
    assert_difference('Control.count') do
      post :create, control: {  }
    end

    assert_response 201
  end

  test "should show control" do
    get :show, id: @control
    assert_response :success
  end

  test "should update control" do
    put :update, id: @control, control: {  }
    assert_response 204
  end

  test "should destroy control" do
    assert_difference('Control.count', -1) do
      delete :destroy, id: @control
    end

    assert_response 204
  end
end
