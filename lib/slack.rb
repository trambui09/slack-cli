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
  puts "\nWelcome to the Ada Slack CLI!"
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

  response = HTTParty.get(
    'https://slack.com/api/conversations.list',
    query: { token: ENV['SLACK_TOKEN'] }
  )

  user_response = HTTParty.get(
    'https://slack.com/api/users.list',
    query: { token: ENV['SLACK_TOKEN'] }
  )

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
  puts 'Please select one of the following menu-options by typing the'
  puts 'number or term (e.g., type "1" or "list-user" for option 1).'
  puts '_______________________________________________________________'
  puts '0. menu-options'
  puts '1. list-user'
  puts '2. list-channel'
  puts '3. quit'
  puts '_______________________________________________________________'

  valid = %w[list-user list-channel quit menu-options 0 1 2 3] + (0..3).to_a
  choice = gets.chomp.downcase
  loop do
    puts 'invalid choice, pick again' unless valid.include?(choice)
    case choice
    when 0, '0', 'menu-options'
      puts '1. list-user'
      puts '2. list-channel'
      puts '3. quit'
    when 1, '1', 'list-user'
      tp workspace.users,:name, :slack_id, :real_name
    when 2, '2', 'list-channel'
      tp workspace.channels, :slack_id, :name, :topic, :member_count
    when 3, '3', 'quit'
      break
    end
    puts 'What would you like to do next?'
    choice = gets.chomp.downcase

  end

  puts 'Thank you for using the Ada Slack CLI'
end

# def valid_choice?(choice)
#   until %w[list-user list-channel quit].include?(choice)
#     puts "invalid choice, pick again"
#     choice = gets.chomp.downcase
#   end
#   return true
# end


main if __FILE__ == $PROGRAM_NAME


