require 'test_helper'

class MissionariosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:missionarios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create missionario" do
    assert_difference('Missionario.count') do
      post :create, :missionario => { }
    end

    assert_redirected_to missionario_path(assigns(:missionario))
  end

  test "should show missionario" do
    get :show, :id => missionarios(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => missionarios(:one).id
    assert_response :success
  end

  test "should update missionario" do
    put :update, :id => missionarios(:one).id, :missionario => { }
    assert_redirected_to missionario_path(assigns(:missionario))
  end

  test "should destroy missionario" do
    assert_difference('Missionario.count', -1) do
      delete :destroy, :id => missionarios(:one).id
    end

    assert_redirected_to missionarios_path
  end
end
