#!/usr/bin/env ruby
require_relative 'workspace'
require 'httparty'
require 'dotenv'
require 'table_print'
require_relative 'user'
require_relative 'recipient'

# add wraper class


Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  # TODO project
  # refactor: dependcies on workspace only
  # wave 1 pseudocode:

  # give the user three options to interact with program ( list user, list channel, quit)
  # in a while loop, keep going, until user enters quit. use loop do, instead of while/until
  # list users in table format with username ('name'), real name ('real_name'), and slack ID('id').
  # list users == workspace.users.list_all
  # list channels : channel's name ('name'), topic ('topic'), member count ('num_members'), and slack ID ('id')
  # list channel == workspace.channels.list_all
  # Q : where should API query go? Part of Recipient?

  response = HTTParty.get('https://slack.com/api/conversations.list', query: {token: ENV['SLACK_TOKEN']})
  user_response = HTTParty.get('https://slack.com/api/users.list', query: {token: ENV['SLACK_TOKEN']})

  # print the name of each channel
  # puts "here's the name for each channel:"
  #pp response
  # response['channels'].each do |channel|
  #   p channel["name"]
  # end

  #pp user_response['members']
  #
  # user_response['members'].each do |user|
  #   p user['name']
  # end
  #

  # CLI loop control
  loop do
    puts "What would you like to do? Type in 'list-user', 'list-channel', or 'quit' to quit"
    choice = gets.chomp.downcase
    until %w[list-user list-channel quit].include?(choice)
      puts "invalid choice, pick again"
      choice = gets.chomp.downcase
    end
    if choice == 'list-user'
      tp workspace.users,:name, :slack_id, :real_name
    elsif choice == 'list-channel'
      tp workspace.channels, :slack_id, :name, :topic, :member_count
    elsif choice == 'quit'
      break
    end

  end

  puts "Thank you for using the Ada Slack CLI"
end

# def valid_choice?(choice)
#   until %w[list-user list-channel quit].include?(choice)
#     puts "invalid choice, pick again"
#     choice = gets.chomp.downcase
#   end
#   return true
# end


main if __FILE__ == $PROGRAM_NAME


