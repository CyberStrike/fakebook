require 'test_helper'

class UserTest < ActiveSupport::TestCase
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
    user = User.new
    user.username = "Spaced Username"
    assert !user.save
    assert !user.errors[:username].empty?
    assert user.errors[:username].include?("Cannot Include Spaces")
  end
end
