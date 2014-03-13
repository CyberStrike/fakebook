require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)

  test "can add a friend" do
    assert_nothing_raised do
      UserFriendship.create user: users(:chris), friend: users(:user3)
    end
  end

  test "can create friends using id" do
    UserFriendship.create user_id: users(:chris).id, friend_id: users(:nyk).id
    assert users(:chris).friends.include?(users(:nyk))
  end
end
