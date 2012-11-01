require 'test_helper'

class CapsulsControllerTest < ActionController::TestCase
  setup do
    @capsul = capsuls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:capsuls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create capsul" do
    assert_difference('Capsul.count') do
      post :create, capsul: { content: @capsul.content, user_id: @capsul.user_id, video: @capsul.video }
    end

    assert_redirected_to capsul_path(assigns(:capsul))
  end

  test "should show capsul" do
    get :show, id: @capsul
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @capsul
    assert_response :success
  end

  test "should update capsul" do
    put :update, id: @capsul, capsul: { content: @capsul.content, user_id: @capsul.user_id, video: @capsul.video }
    assert_redirected_to capsul_path(assigns(:capsul))
  end

  test "should destroy capsul" do
    assert_difference('Capsul.count', -1) do
      delete :destroy, id: @capsul
    end

    assert_redirected_to capsuls_path
  end
end
