require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should have_many(:user_friendships)
  should have_many(:friends)

  test "A user should enter their first name" do
    user = User.new
    assert !user.save
    assert !user.errors[:first_name].empty?
    end

  test "A user should enter their last name" do
    user = User.new
    assert !user.save
    assert !user.errors[:last_name].empty?
    end

  test "A user should enter a username" do
    user = User.new
    assert !user.save
    assert !user.errors[:username].empty?
    end

   test "A user should have a unique username" do
    user = User.new
    user.first_name = 'Chris'
    user.last_name = 'Scott'
    user.username = 'cyberstrike'
    user.email = 'cyberstrike@gmail.com'
    user.password = '123456789'
    user.password_confirmation = '123456789'
    assert !user.save
    assert !user.errors[:username].empty?
  end

  test "A user should have a unique username with no spaces" do
    user = User.new(first_name: 'Chris', last_name: 'Scott', email: 'cyberstrike@gmail.com')
    user.password = user.password_confirmation = '123456789'
    user.username = "Spaced Username"
    assert !user.save
    assert !user.errors[:username].empty?
    assert user.errors[:username].include?("Cannot Include Spaces")
  end

  test "A user has a properly formatted username" do
    user = User.new(first_name: 'Chris', last_name: 'Scott', email: 'cyberstrike@gmail.com')
    user.username = 'cyberstrike_1 '
    assert !user.valid?
  end

  #Friends

  test "can view friendlist" do
    assert_nothing_raised do
      users(:chris).friends
    end
  end

  test "can create a friend" do
    users(:chris).friends << users(:nyk)
    users(:chris).friends.reload
    assert users(:chris).friends.include?(users(:nyk))
  end

  test "calling to_params on user returns username" do
    assert_equal users(:chris).username, users(:chris).to_param
  end

end
