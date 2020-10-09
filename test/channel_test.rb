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
end