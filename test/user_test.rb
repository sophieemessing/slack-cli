require_relative 'test_helper'
require_relative '../lib/slack'

describe "User class" do
  describe "user list_all" do
    it "can call the API and receive a response" do
      VCR.use_cassette("user_instance") do
        all_users = User.list_all

        expect(all_users).must_be_instance_of Array

        all_users.each do |user|
          expect(user).must_be_instance_of User
        end
      end
  end
  end
  end

# return nil for invalid input
# workspacehas list ofsers and channels
# canfind user by ID
# can find user by name
# canfind channel by ID
# can find channel name
