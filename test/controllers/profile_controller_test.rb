require 'test_helper'

class ProfileControllerTest < ActionController::TestCase
  test "get show" do
    get :show, id: users(:chris).username
    assert_response :success
    assert_template 'profile/show'
  end

  test "for fake user" do
    get :show, id: "fake user"
    assert_response :not_found
  end

  test "correctly assigned user variables" do
    get :show, id: users(:chris).username
    assert assigns(:user)
    assert_not_empty assigns(:statuses)
  end

end
