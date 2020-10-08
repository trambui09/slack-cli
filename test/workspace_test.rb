# require 'simplecov'
# SimpleCov.start

require_relative 'test_helper'
require_relative '../lib/workspace'


describe "Workspace" do
  before do
    VCR.use_cassette("making new workspace") do
      @workspace = Workspace.new
      @user_test = @workspace.select_user("slackbot")
      @channel_test = @workspace.select_channel("random")
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
      expect(@workspace.select_user('slackbot')).must_be_kind_of String
      # how can we test if it's returning the right instance of User?
      # expect(@workspace.select_user('pbui17')).must_equal @workspace.users.name

      selected_user = @workspace.select_user('pbui17')
      expect(@workspace.selected.slack_id).must_equal 'U01C0H7QZRQ'

    end

    it "display if the user is not found" do
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
      expect(@workspace.select_channel('random')).must_be_kind_of String

      expect(
        @workspace.select_channel('random')
      ).must_equal "#{@workspace.selected.name} found! Type 'details' to display " +
                   "information about the #{@workspace.selected.name} channel."

      expect(@workspace.selected.slack_id).must_equal 'C01C0H7R9QS'

    end

    it "let user know that channel wasn't found" do
      expect(
        @workspace.select_channel('bogus')
      ).must_equal "Sorry no channel has that name or ID"
    end

  end

  describe "show details" do
    it "must respond to the method call" do
      expect(@workspace).must_respond_to :show_details
    end

    it "displays information for the selected recipient" do
      # user_test = @workspace.select_user("slackbot")
      expect(@workspace.selected.show_details).must_be_kind_of User
      expect(@workspace.selected.show_details).must_be_kind_of Channel

      it 'returns a string/message if invalid information is passed in' do
        selected_user = @workspace.select_user('bogus1')
        selected_channel = @workspace.select_channel('bogus2')
        expect(selected_user.show_details).must_equal 'no recipient currently selected'
        expect(selected_channel.show_details).must_equal 'no recipient currently selected'
      end
    end
  end

end