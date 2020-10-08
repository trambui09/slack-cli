require_relative 'user'
require_relative 'channel'

class Workspace

  attr_reader :users, :channels
  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    # we need to utilize this somehow
    @selected = []
  end

  # is is possible for two users to have the same username?
  def select_user(id)
    # find wouldn't return an array, it would return an object type
    # select would return an array
    # which one should we pick?
    user_array = @users.find do |user|
      user.slack_id == id || user.name == id
    end

    # return user_array unless user_array.nil?
    # # should this be SlackApiError?
    # # if the user_array is nil, raising an SlackApiError seems weird
    # # means that you can't find the person
    # raise SlackAPIError.new, "user/ID not found"

    if user_array.nil?
      return "Sorry no user has that name or ID"
    else
      return user_array
    end

  end

  def select_channel(id)

    select_channel = @channels.find do |channel|
      channel.slack_id == id || channel.name == id
    end

    select_channel.nil? ? "sorry no channel was found" : select_channel

  end

  # the program should print out details for the currently selected recipient.
  # how do we know who is the current recipient?
  def show_details

  end

end