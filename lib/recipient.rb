require 'dotenv'
require 'httparty'

Dotenv.load
class SlackAPIError < Exception; end
#Module?
class Recipient

  USER_LIST_URL = 'https://slack.com/api/users.list'
  CHANNEL_LIST_URL = 'https://slack.com/api/conversations.list'
  MESSAGE_LIST_URL = 'https://slack.com/api/chat.postMessage'

  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def send_message(message)
    response = HTTParty.post(MESSAGE_LIST_URL, body: {
      token: ENV['SLACK_TOKEN'],
      text: 'message',
      channel: @slack_id
    }
    )
  end

  def self.get(url, params)
    response = HTTParty.get(url, params)
    unless response['ok'] == true
      raise SlackAPIError, "API call failed with code #{response.response.code}"
    end

    return response
  end

  def details
    # implement me in child class
    raise NotImplementedError.new, 'Must implement me in child class!'
  end

  def self.list_all
    # implement me in child class
    raise NotImplementedError.new, 'Must implement me in child class!'
  end


end
