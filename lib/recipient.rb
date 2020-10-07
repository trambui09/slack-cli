require 'dotenv'
require 'httparty'

Dotenv.load

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
    return HTTParty.get(url, params)
  end

  def details
  end

  def self.list_all
    # implement me in child class
    raise NotImplementedError.new, "Must implement me in child class!"
  end


end
