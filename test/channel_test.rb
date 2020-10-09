require_relative 'test_helper'
require_relative '../lib/slack'

describe "Channel class" do
  describe "channel list_all" do
    it "can call the API and receive a response" do
      VCR.use_cassette("channel_instance") do
        all_channels = Channel.list_all

        expect(all_channels).must_be_instance_of Array

        all_channels.each do |channel|
          expect(channel).must_be_instance_of Channel
        end
      end
    end
  end

  describe "send message" do

    it "can send a message to a channel" do
      VCR.use_cassette("channel_send_message") do
        channel = Channel.new("C01BTVCEXCN", "general", "topic", 3)
        channel.send_message("This post should work")
      end
    end

    it "will not send a message for invalid channel ID" do
      VCR.use_cassette("channel_send_message") do
        channel = Channel.new(99999, "test_channel", "this is a fake channel", 3)
        expect { channel.send_message("This post should not work") }.must_raise SlackApiError
      end
    end

    it "returns an error for an invalid token" do
      VCR.use_cassette("channel_send_not_authed") do
        channel = Channel.new("C01BTVCEXCN", "general", "topic", 3)

        expect { channel.send_message("This post should not work") }.must_raise SlackApiError
      end
    end
  end
end