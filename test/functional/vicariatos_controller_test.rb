require 'test_helper'

class VicariatosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vicariatos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vicariato" do
    assert_difference('Vicariato.count') do
      post :create, :vicariato => { }
    end

    assert_redirected_to vicariato_path(assigns(:vicariato))
  end

  test "should show vicariato" do
    get :show, :id => vicariatos(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => vicariatos(:one).id
    assert_response :success
  end

  test "should update vicariato" do
    put :update, :id => vicariatos(:one).id, :vicariato => { }
    assert_redirected_to vicariato_path(assigns(:vicariato))
  end

  test "should destroy vicariato" do
    assert_difference('Vicariato.count', -1) do
      delete :destroy, :id => vicariatos(:one).id
    end

    assert_redirected_to vicariatos_path
  end
end
