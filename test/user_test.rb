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

  describe "send message" do

    it "can send a message to a user" do
      VCR.use_cassette("user_send_message") do
        user = User.new("U01CQGU5LKS", "mahaelmais", "mahaelmais", "", "")
        user.send_message("This post should work")
      end
    end

    it "will not send a message for invalid user ID" do
      VCR.use_cassette("user_send_message") do
        user = User.new(99999, "test_user", "fake_user", "", "")
        expect { user.send_message("This post should not work") }.must_raise SlackApiError
      end
    end

    it "returns an error for an invalid token" do
      VCR.use_cassette("user_send_not_authed") do
        user = User.new("U01CQGU5LKS", "mahaelmais", "mahaelmais", "", "")

        expect { user.send_message("This post should not work") }.must_raise SlackApiError
      end
    end
  end

end