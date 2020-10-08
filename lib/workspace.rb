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
      user_data << user.information
    end
    return user_data
  end

  def list_channels
    channel_data = []
    @channels.each do |channel|
      channel_data << channel.information
    end
    return channel_data
  end

  def select_channel(input)
    @selected = @channels.find { |channel| input == channel.name || input == channel.slack_id}
    raise ArgumentError.new("#{input} not found") if @selected == nil
    return @selected
  end

  def select_user(input)
    @selected = @users.find { |user| input == user.name || input == user.slack_id}
    raise ArgumentError.new("#{input} not found") if @selected == nil
    return @selected
  end

  def show_details
    raise ArgumentError.new("no user or channel selected") if @selected == nil
    return @selected.information
  end

  def send_message

  end

end
