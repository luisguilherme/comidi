require 'test_helper'

class ForaniasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:foranias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create forania" do
    assert_difference('Forania.count') do
      post :create, :forania => { }
    end

    assert_redirected_to forania_path(assigns(:forania))
  end

  test "should show forania" do
    get :show, :id => foranias(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => foranias(:one).id
    assert_response :success
  end

  test "should update forania" do
    put :update, :id => foranias(:one).id, :forania => { }
    assert_redirected_to forania_path(assigns(:forania))
  end

  test "should destroy forania" do
    assert_difference('Forania.count', -1) do
      delete :destroy, :id => foranias(:one).id
    end

    assert_redirected_to foranias_path
  end
end
