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

    puts "user #{id} not found" if @selected.nil?

    return @selected

  end

  def select_channel(id)

    select_channel = @channels.find do |channel|
      channel.slack_id == id || channel.name == id
    end

    @selected = select_channel

    puts "channel #{id} not found" if @selected.nil?

    return @selected

  end

  # the program should print out details for the currently selected recipient.
  # how do we know who is the current recipient?
  def show_details
    if @selected.nil?
      puts 'no recipient currently selected'
    else
      return @selected.details
    end
  end

  def send_message(message)
    @selected.send_message(message)
  end
end