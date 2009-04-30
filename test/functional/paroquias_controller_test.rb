require 'test_helper'

class ParoquiasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paroquias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paroquia" do
    assert_difference('Paroquia.count') do
      post :create, :paroquia => { }
    end

    assert_redirected_to paroquia_path(assigns(:paroquia))
  end

  test "should show paroquia" do
    get :show, :id => paroquias(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => paroquias(:one).id
    assert_response :success
  end

  test "should update paroquia" do
    put :update, :id => paroquias(:one).id, :paroquia => { }
    assert_redirected_to paroquia_path(assigns(:paroquia))
  end

  test "should destroy paroquia" do
    assert_difference('Paroquia.count', -1) do
      delete :destroy, :id => paroquias(:one).id
    end

    assert_redirected_to paroquias_path
  end
end
