require 'test_helper'

  class StatusTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end

    test "Status requires content" do
      status = Status.new
      assert ! status.save
      assert ! status.errors[:content].empty?
    end

    test "Status content cannot be less than two characters" do
      status = Status.new
      status.content = "h"
      assert ! status.save
      assert ! status.errors[:content].empty?
    end

    test "Status requires a user" do
      status = Status.new
      status.content = "Helloooo Nurse!"
      assert ! status.save
      assert ! status.errors[:user_id].empty?
    end
  end