# require 'simplecov'
# SimpleCov.start

require_relative 'test_helper'
require_relative '../lib/workspace'


describe "Workspace" do
  before do
    VCR.use_cassette("making new workspace") do
      @workspace = Workspace.new
    end
  end
  describe "constructor" do
    it "returns class instances" do
      expect(@workspace.users).must_be_kind_of Array
      expect(@workspace.channels).must_be_kind_of Array
    end

  end

  describe "select_user method" do
    it "responds to the method call" do
      expect(@workspace).must_respond_to :select_user
    end

    it "returns the correct user instance" do
      expect(@workspace.select_user('USLACKBOT')).must_be_kind_of User
      # how can we test if it's returning the right instance of User?
      # expect(@workspace.select_user('pbui17')).must_equal @workspace.users.name

      selected_user = @workspace.select_user('pbui17')
      expect(selected_user.slack_id).must_equal 'U01C0H7QZRQ'

    end

    it "raises an error if the user is not found" do
      expect(
        @workspace.select_user('bogus')
      ).must_equal "Sorry no user has that name or ID"
    end

  end

  describe "select_channel" do
    it "responds to the method call" do
      expect(@workspace).must_respond_to :select_channel
    end

    it "returns the correct channel instance" do
      expect(@workspace.select_channel('random')).must_be_kind_of Channel

      selected_channel = @workspace.select_channel('random')
      expect(selected_channel.slack_id).must_equal 'C01C0H7R9QS'

    end

    it "let user know that channel wasn't found" do
      expect(
        @workspace.select_channel('bogus')
      ).must_equal 'sorry no channel was found'
    end

  end

  describe "show details" do
    it " " do

    end

  end

end