require 'dotenv'
require 'httparty'

Dotenv.load
class SlackApiError < Exception; end
#Module?
class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def send_message(message)
  end

  def self.get(url, params)
    #TODO: change variable name so it's not response.response
    response = HTTParty.get(url, params)
    if response.response.code == '404'
      raise SlackApiError, "API call failed with code #{response['error']}"
    end

    return response
  end

  def details
  end

  def self.list_all
    # implement me in child class
    raise NotImplementedError.new, 'Must implement me in child class!'
  end


end
