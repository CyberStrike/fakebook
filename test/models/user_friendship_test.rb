require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)

  test 'can add a friend' do
    assert_nothing_raised do
      UserFriendship.create user: users(:chris), friend: users(:user3)
    end
  end

  test 'can create friends using id' do
    UserFriendship.create user_id: users(:chris).id, friend_id: users(:nyk).id
    assert users(:chris).friends.include?(users(:nyk))
  end

  context 'a new instance' do
    setup do
      @user_friendship = UserFriendship.new user_id: users(:chris), friend_id: users(:nyk)
    end

    should 'have pending' do
      assert_equal 'pending', @user_friendship.state
    end

  end

  context '#send request email' do

    setup do
      @user_friendship = UserFriendship.create user: users(:chris), friend: users(:vanessa)
    end

    should 'send a request email' do
      assert_difference 'ActionMailer::Base.deliveries.size', 1 do
        @user_friendship.send_request
      end
    end

  end
end
