#module Slack
require_relative 'recipient'
require 'dotenv'
require 'httparty'

Dotenv.load

class User < Recipient
  USER_LIST_URL = 'https://slack.com/api/users.list'

  class SlackApiError < Exception; end

  attr_reader :real_name, :status_text, :status_emoji

  # don't know if this is how we truly initialize this constructor

  def initialize(slack_id:, name:, real_name:, status_text:, status_emoji:)
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def details
  end

  def self.list_all
    # build and send the request

    #token = ENV['SLACK_TOKEN']

    # response = HTTParty.get(USER_LIST_URL, query: {token: ENV['SLACK_TOKEN']})

    response = self.get(USER_LIST_URL, query: {token: ENV['SLACK_TOKEN']} )

    if response['ok'] == false
      raise SlackApiError, "API call failed with code #{response['error']}"
    end


    users = response['members'].map do |user|
      self.new(slack_id: user['id'],
               name: user['name'],
               real_name: user['real_name'],
               status_text: user['status_text'],
               status_emoji: user['status_emoji']
      )
    end

    return users



  end

end