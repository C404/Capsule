require 'test_helper'

class ProfileControllerTest < ActionController::TestCase
  test "should get profile" do
    get :profile
    assert_response :success
  end

  test "should get me" do
    get :me
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get all" do
    get :all
    assert_response :success
  end

end
