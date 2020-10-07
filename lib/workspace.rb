require_relative 'user'
require_relative 'channel'

class Workspace

  attr_reader :users, :channels
  def initialize
    @users = User.list_all
    @channels = Channel.list_all
  end

  def select_user(id)
    # if @users.slack_id.nil? || @users.name.nil?
    #   # raise error
    # end
    user_array = @users.find do |user|
       user.slack_id == id
    end

    unless user_array
      raise ArgumentError.new 'user not found'
    end


    selected_user = @users.select { |user| user == id}
    return selected_user
  end

  def select_channel(id)

  end

end