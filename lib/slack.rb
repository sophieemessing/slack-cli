
require 'prettyprint'
require 'awesome_print'
require 'httparty'
require 'dotenv'

Dotenv.load

require_relative 'workspace'

def main

  begin
  workspace = Workspace.new
  rescue SlackApiError => error
    puts "error occurred: #{error.message}"
    return
  end

  puts "\nWelcome to the Ada Slack CLI!"
  puts "There are #{workspace.users.length} users and #{workspace.channels.length} channels."

  statement = "\nPlease enter one of the following commands:\n• list users\n• list channels\n• select user\n• select channel\n• show details\n• send a message\n• quit\n"

  until false

    puts statement
    puts "\n"
    input = gets.chomp.downcase

    begin
      case input
      when "list users"
        puts workspace.list_users
      when "list channels"
        puts workspace.list_channels

      when "select channel"
        puts "Please enter a channel name or ID:"
        input = gets.chomp
        workspace.select_channel(input)

        until workspace.select_channel(input) != nil
          puts "Invalid channel #{input}. Please try again."
          input = gets.chomp
          workspace.select_channel(input)
        end

        puts "\n Selected channel: #{workspace.selected.name} \n ID: #{workspace.selected.slack_id}"
        puts " Enter #{"show details"} for more details on #{workspace.selected.name}"

      when "select user"
        puts "Please enter a username or ID:"
        input = gets.chomp
        workspace.select_user(input)

        until workspace.select_user(input) != nil
          puts "Invalid user #{input}. Please try again."
          input = gets.chomp
          workspace.select_user(input)
        end

        puts "\n Selected user: #{workspace.selected.name} \n ID: #{workspace.selected.slack_id}"
        puts " Enter #{"show details"} for more details on #{workspace.selected.name}"

      when "show details"
        if workspace.selected == nil
          puts "Details for whom? Please enter a user or channel"
          input = gets.chomp
          workspace.ask_to_select(input)
          until workspace.ask_to_select(input) != nil
            puts "Invalid input #{input}. Please try again."
            input = gets.chomp
            workspace.ask_to_select(input)
          end
        end

        puts workspace.show_details

      when "send a message"
        if workspace.selected == nil
          puts "To whom?"
          input = gets.chomp
          workspace.ask_to_select(input)
          until workspace.ask_to_select(input) != nil
            puts "Invalid input #{input}. Please try again."
            input = gets.chomp
            workspace.ask_to_select(input)
          end
        end

        puts "What message would you like to send?"
        message = gets.chomp.to_s
        puts workspace.send_message(message)
        puts "message #{message} sent successfully!"

      when "quit"
        puts "Thank you for using the Ada Slack CLI"
        break
      else
        puts "Invalid input #{input}"
      end
    rescue SlackApiError => error
      puts "error occurred: #{error.message}"
    end
  end
end


main if __FILE__ == $PROGRAM_NAME
