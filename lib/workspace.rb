require_relative 'user'
require_relative 'channel'

class Workspace

  attr_reader :users, :channels
  def initialize
    @users = User.list_all
    @channels = Channel.list_all
  end

  # is is possible for two users to have the same username?
  def select_user(id)
    user_array = @users.find do |user|
      user.slack_id == id || user.name == id
    end
    return user_array

  end

  def select_channel(id)

  end

end