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
        get :new, {friend_id: users(:nyk).id}
        assert_match(/#{users(:nyk).full_name}/, response.body)
      end

      should 'make a new friend' do
        get :new, friend_id: users(:nyk).id
        assert assigns(:user_friendship)
      end

      should 'new friend equals passed friend' do
        get :new, friend_id: users(:nyk).id
        assert_equal users(:nyk), assigns(:user_friendship).friend
        end

      should 'new friend equals current user' do
        get :new, friend_id: users(:user3).id
        assert_equal users(:chris), assigns(:user_friendship).user
      end
    end
  end

  context "#create" do
    should "redirect to login if not logged in" do
      post :create
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    context 'when logged in' do

      setup do
        sign_in users(:chris)
      end

      context 'with no friend id' do

        setup do
          post :create
        end

        should "get flash alert" do
          assert !flash[:alert].empty?
        end

        should 'be redirected to root' do
          assert_redirected_to root_path
        end

      end

      context 'with a friend id' do

        setup do
          post :create, friend_id: users(:nyk)
        end

        should 'assign friend' do
          assert assigns(:friend)
          assert_equal users(:nyk), assigns(:friend)
        end

        should 'assign user friendship' do
          assert assigns(:user_friendship)
          assert_equal users(:nyk), assigns(:user_friendship).friend
          assert_equal users(:chris), assigns(:user_friendship).user
        end

        should 'create a friendship' do
          assert users(:chris).friends.include?(users(:nyk))
        end

        should 'redirect to friends profile page' do
          assert_response :redirect
          assert_redirected_to profile_path(users(:nyk).username)
        end

        should 'flash success msg' do
          assert flash[:success]
          assert_equal "You are now friend with #{users(:nyk).first_name}", flash[:success]
        end
      end

    end

  end
end
