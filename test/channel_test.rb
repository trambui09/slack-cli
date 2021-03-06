require_relative 'test_helper'
require_relative '../lib/channel'
require_relative '../lib/recipient'

describe 'Channel' do
  before do
    @channel = Channel.new(
        slack_id: 'C01C0H7R9QS',
        name: 'random',
        topic: 'kombucha',
        member_count: 3
    )

    VCR.use_cassette('list channels') do
      @response = Channel.list_all
    end
  end

  describe 'constructor' do
    it 'creates instance of Channel' do
      expect(@channel).must_be_kind_of Channel
    end



    it "respons to the attr_reader" do
      [:slack_id, :name, :topic, :member_count].each do |prop|
        expect(@channel).must_respond_to prop
      end
    end

    it 'check attribute data types' do
      expect(@channel.name).must_be_kind_of String
      expect(@channel.name).must_equal 'random'
      expect(@channel.slack_id).must_be_kind_of String
      expect(@channel.slack_id).must_equal 'C01C0H7R9QS'
      expect(@channel.topic).must_be_kind_of String
      expect(@channel.member_count).must_be_kind_of Integer
    end
  end

  describe "details" do
    it " returns a string with the details on the channel" do
      expect(@channel.details).must_equal "Slack ID: #{@channel.slack_id} \nName: #{@channel.name} \nMember Count: #{@channel.member_count}"
    end
  end

  describe 'list_all' do
    it 'lists channels' do
      VCR.use_cassette('channels-list') do
        response = Channel.get(
          'https://slack.com/api/conversations.list',
          query: { token: ENV['SLACK_TOKEN'] }
        )

        expect(response['channels']).must_be_kind_of Array
        expect(response['ok']).must_equal true
        expect(response.code).must_equal 200

        @channels = Channel.list_all

        expect(@channels.length).must_equal response.length

        # can't test if first channel matched because we are connected
        # to different workspaces, so we don't know which channel would
        # be first in both of our workspaces

      end
    end

    it "returns each channel in the array should be an instance of channel" do
      @response.each do |channel|
        expect(channel).must_be_kind_of Channel
      end
    end

    it "must have at least 1 channel" do
      expect(@response.length).must_be :>,0
    end

    it 'error when API call fails' do
      VCR.use_cassette('API-fail') do
        expect do
          Channel.get(
            'https://slack.com/api/conversations.words_are_hard',
            query: { token: ENV['SLACK_TOKEN'] }
          )
        end.must_raise SlackAPIError
      end
    end

    it "rescues the error - doesn't throw an error" do
      VCR.use_cassette('rescue-channel-error') do
        expect(Channel.list_all).must_be_nil
      end
    end
  end
end
