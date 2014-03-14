require 'test_helper'

class UserFriendshipsControllerTest < ActionController::TestCase

  context '#new' do

    context 'when the user is not logged in' do
      should 'redirect to the login page' do
        get :new
        assert_response :redirect
      end
    end

    context 'when the user is logged in' do

      setup do
        sign_in users(:chris)
      end

      should 'see new friendship' do
        get :new
        assert_response :success
      end

      should 'flash error for invalid params' do
        get :new, {}
        assert_equal "Friend not found", flash[:alert]
      end

      should 'show friends name' do
        get :new, friend_id: users(:nyk).id
        assert_match(/#{users(:nyk).full_name}/, response.body)
      end

      should 'make a new friend' do
        get :new, friend_id: users(:nyk).id
        assert assigns(:user_friendship)
      end

      should 'new friend equals current user' do
        get :new, friend_id: users(:nyk).id
        assert_equal users(:chris), assigns(:user_friendship).friend
      end

    end
  end
end
