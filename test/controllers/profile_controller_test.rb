require 'test_helper'

class ProfileControllerTest < ActionController::TestCase
  test "get show" do
    get :show, username: users(:chris).username
    assert_response :success
    assert_template 'profile/show'
  end

  test "for fake user" do
    get :show, username: "fake user"
    assert_response :not_found
  end

  test "correctly assign user variables" do
    get :show, username: users(:chris).username
    assert assigns(:user)
    assert_not_empty assigns(:statuses)
  end

  test 'statuses shown belong to scoped user' do
    get :show, username: users(:chris).username
    assigns(:statuses).each do |status|
      assert_equal users(:chris), status.user
    end
  end

end
