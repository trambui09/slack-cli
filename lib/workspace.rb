require_relative 'user'
require_relative 'channel'

class Workspace

  attr_reader :users, :channels
  def initialize
    @users = []
    @channels = []
  end

end