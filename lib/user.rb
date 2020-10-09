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
    info = "Slack ID: #{@slack_id} \nName: #{@name}"
    return info
  end

  def self.list_all

    begin
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

    rescue SlackAPIError => exception
      puts '🔥👾👾🔥👾🔥👾👾🔥👾🔥👾👾🔥👾👾🔥👾👾🔥👾👾🔥👾👾🔥'
      puts "Encountered an error: #{exception}"
      puts '🔥👾👾🔥👾🔥👾👾🔥👾🔥👾👾🔥👾👾🔥👾👾🔥👾👾🔥👾👾🔥'
    end

  end
end
