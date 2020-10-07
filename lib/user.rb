#module Slack

require_relative 'recipient'
require 'dotenv'
require 'httparty'

Dotenv.load

class User < Recipient

  attr_reader :real_name, :status_text, :status_emoji

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

    response = get(USER_LIST_URL, query: { token: ENV['SLACK_TOKEN'] })

    users = response['members'].map do |user|
      new(
        slack_id: user['id'],
        name: user['name'],
        real_name: user['real_name'],
        status_text: user['status_text'],
        status_emoji: user['status_emoji']
      )
    end

    return users



  end

end
