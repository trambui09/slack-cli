# Module Slack
require_relative 'recipient'

class Channel < Recipient
  attr_reader :topic, :member_count

  def initialize(slack_id:, name:, topic:, member_count:)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  def details
    info = "Slack ID: #{@slack_id}, Name: #{@name}, Member Count: #{@member_count}"
    return info
  end

  def self.list_all

    response = get(CHANNEL_LIST_URL, query: {token: ENV['SLACK_TOKEN']} )

    channels = response['channels'].map do |channel|
      new(
        slack_id: channel['id'],
        name: channel['name'],
        topic: channel['topic'],
        member_count: channel['num_members']
      )
    end

    return channels
  end

end