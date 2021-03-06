require 'httparty'
require 'dotenv'

require_relative 'user'
require_relative 'channel'

Dotenv.load

class Workspace

  attr_reader :users,:channels,:selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  def list_users
    user_data = []
    @users.each do |user|
      user_data << user.details
    end
    return user_data
  end

  def list_channels
    channel_data = []
    @channels.each do |channel|
      channel_data << channel.details
    end
    return channel_data
  end

  def select_channel(input)
    @selected = @channels.find { |channel| input == channel.name || input == channel.slack_id}
    return @selected
  end

  def select_user(input)
    @selected = @users.find { |user| input == user.name || input == user.slack_id}
    return @selected
  end

  def ask_to_select(input)
    select_channel(input)
    if @selected == nil
      select_user(input)
    end
    return @selected
  end

  def show_details
    raise SlackApiError.new("no user or channel selected") if @selected == nil
    return @selected.details
  end

  def send_message(message)
    raise SlackApiError.new("no user or channel selected") if @selected == nil
    @selected.send_message(message)
  end
end


