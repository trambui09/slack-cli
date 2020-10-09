require_relative 'user'
require_relative 'channel'

class Workspace

  attr_reader :users, :channels
  attr_accessor :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  # is is possible for two users to have the same username?
  def select_user(id)

    user_array = @users.find do |user|
      user.slack_id == id || user.name == id
    end
    # @selected is an instance of the chosen user
    @selected = user_array

    puts "user #{id} not found" if @selected.nil?

    return @selected

  end

  def select_channel(id)

    select_channel = @channels.find do |channel|
      channel.slack_id == id || channel.name == id
    end
    # @selected is an instance of the chosen channel
    @selected = select_channel

    puts "channel #{id} not found" if @selected.nil?

    return @selected

  end

  def show_details
    if @selected.nil?
      puts 'no recipient currently selected'
    else
      return @selected.details
    end
  end

  def send_message(msg)
    if @selected.nil?
      puts "no recipient is currently selected"
    else
      begin
        return @selected.send_message(msg)
      rescue SlackAPIError => exception
        puts '🔥👾👾🔥👾🔥👾👾🔥👾🔥👾👾🔥👾👾🔥👾👾🔥👾👾🔥👾👾🔥'
        puts "Encountered an error: #{exception}"
        puts '🔥👾👾🔥👾🔥👾👾🔥👾🔥👾👾🔥👾👾🔥👾👾🔥👾👾🔥👾👾🔥'
      end
    end
  end
end

