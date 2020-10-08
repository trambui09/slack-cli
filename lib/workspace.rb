require_relative 'user'
require_relative 'channel'

class Workspace

  attr_reader :users, :channels
  attr_accessor :selected
  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    # we need to utilize this somehow
    @selected = nil
  end

  # is is possible for two users to have the same username?
  def select_user(id)
    # find wouldn't return an array, it would return an object type
    # select would return an array
    # which one should we pick?
    user_array = @users.find do |user|
      user.slack_id == id || user.name == id
    end

    @selected = user_array

    if @selected.nil?
      return "Sorry no user has that name or ID"
    else

      return "#{@selected.name} found! Type 'details' to display " +
            "user information about #{@selected.real_name}."
    end

  end

  def select_channel(id)

    select_channel = @channels.find do |channel|
      channel.slack_id == id || channel.name == id
    end

    @selected = select_channel

    if @selected.nil?
      return "Sorry no channel has that name or ID"
    else
      return "#{@selected.name} found! Type 'details' to display " +
          "information about the #{@selected.name} channel."
    end

  end

  # the program should print out details for the currently selected recipient.
  # how do we know who is the current recipient?
  def show_details
    @selected.details

  end
end