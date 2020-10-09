require_relative 'test_helper'
require_relative '../lib/slack'

describe "Workspace" do
  describe "can initialize a workspace" do
    before do
      VCR.use_cassette("workspace") do
        @workspace = Workspace.new
      end
    end

    it "can initialize a workspace" do

      expect(@workspace).must_be_kind_of Workspace
      expect(@workspace.users).must_be_kind_of Array
      expect(@workspace.channels).must_be_kind_of Array
      expect(@workspace.selected).must_be_nil
    end

    it "initializes with user and channel objects" do

      expect(@workspace.users.first).must_be_kind_of User
      expect(@workspace.channels.first).must_be_kind_of Channel
    end
  end

  describe "can list users and channels" do
    before do
      VCR.use_cassette("workspace_list_all") do
        @workspace = Workspace.new
      end
    end

    it "can list all users" do

      expect(@workspace.list_users).must_be_kind_of Array
      expect(@workspace.list_users.length).must_equal 6
      expect(@workspace.list_users.first).must_be_kind_of String

    end

    it "can list all channels" do

      expect(@workspace.list_channels).must_be_kind_of Array
      expect(@workspace.list_channels.length).must_equal 4
      expect(@workspace.list_channels.first).must_be_kind_of String

    end
  end

  describe "can select users or channels" do
    before do
      VCR.use_cassette("select_channels") do
        @workspace = Workspace.new
      end
    end

    it "can select a user by name" do
      user = @workspace.select_user("slackbot")
      expect(user).must_be_instance_of User
      expect(user.name).must_equal "slackbot"

      user = @workspace.select_user("mahaelmais")
      expect(user).must_be_instance_of User
      expect(user.name).must_equal "mahaelmais"
      expect(user.slack_id).must_equal "U01CQGU5LKS"
    end

    it "can select a user by ID" do
      user = @workspace.select_user("U01BXJZPYAH")
      expect(user).must_be_instance_of User
      expect(user.name).must_equal "sophie.e.messing"
      expect(user.slack_id).must_equal "U01BXJZPYAH"

      user = @workspace.select_user("U01CQHU8WBS")
      expect(user).must_be_instance_of User
      expect(user.name).must_equal "earth_mahaelmais_api_"
      expect(user.slack_id).must_equal "U01CQHU8WBS"
    end

    it "can select a channel by name" do
      channel = @workspace.select_channel("random")
      expect(channel).must_be_instance_of Channel
      expect(channel.name).must_equal "random"
      expect(channel.slack_id).must_equal "C01C0TJK6G3"

    end

    it "can select a channel by ID" do
      channel = @workspace.select_channel("C01BXNGFDTP")
      expect(channel).must_be_instance_of Channel
      expect(channel.name).must_equal "test-channel"
      expect(channel.slack_id).must_equal "C01BXNGFDTP"

    end

    it "will return nil for invalid user input" do
      user = @workspace.select_user("xxx")
      expect(user).must_be_nil
    end

    it "will return nil for invalid channel input" do
      user = @workspace.select_user("00001111")
      expect(user).must_be_nil
    end

    it "can show details for selected user" do
      user = @workspace.select_user("mahaelmais")
      user_details = @workspace.show_details

      expect(user_details).must_be_kind_of String
      expect(user_details).must_include "U01CQGU5LKS"
    end

    it "can show details for selected channel" do
      channel = @workspace.select_channel("general")
      channel_details = @workspace.show_details

      expect(channel_details).must_be_kind_of String
      expect(channel_details).must_include "C01BTVCEXCN"
    end
  end

  describe "send_message" do
    before do
      VCR.use_cassette("send_message") do
        @workspace = Workspace.new
      end
    end

    it "can send a message" do
      VCR.use_cassette("send_message") do
        @workspace.select_user("sophie.e.messing")
        @workspace.send_message("This post should work")
      end
    end

    it "will raise an error if we send a message with no channel or user" do
      expect { @workspace.send_message("This post should not work") }.must_raise SlackApiError
    end
  end

  describe "ask_to_select" do
    it"can select a user" do
      VCR.use_cassette("ask_to_select") do
        @workspace = Workspace.new
      end
      expect(@workspace.ask_to_select("sophie.e.messing")).wont_be_nil
    end

    it"can select a channel" do
      VCR.use_cassette("ask_to_select") do
        @workspace = Workspace.new
      end
      expect(@workspace.ask_to_select("general")).wont_be_nil
    end

    it"can't select invalid input" do
      VCR.use_cassette("ask_to_select") do
        @workspace = Workspace.new
      end
      expect(@workspace.ask_to_select("xxxxxxxxxx")).must_be_nil
    end

  end
end




