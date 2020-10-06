#!/usr/bin/env ruby
require_relative 'workspace'
require 'httparty'
require 'dotenv'

Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  # TODO project
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
  puts "here's the name for each channel:"
  #pp response
  # response['channels'].each do |channel|
  #   p channel["name"]
  # end

  pp user_response

  user_response['members'].each do |user|
    p user['name']
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME


