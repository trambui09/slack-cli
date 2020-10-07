require_relative 'test_helper'
require_relative '../lib/channel'
require_relative '../lib/recipient'
# https://api.slack.com/methods/conversations.list
# Any tests involving a `Channel` should use the `#random` channel
describe 'Channel' do
  describe 'create instance of Channel for tests' do
    before do
      @channel = Channel.new(
        slack_id: '987654321',
        name: 'random',
        topic: 'kombucha',
        member_count: '42'
      )
    end

    describe 'constructor' do
      it 'creates instance of User' do
        expect(@channel).must_be_kind_of Channel
      end

      it 'check attribute data types' do
        expect(@channel.name).must_be_kind_of String
        expect(@channel.slack_id).must_be_kind_of String
        expect(@channel.topic).must_be_kind_of String
        expect(@channel.member_count).must_be_kind_of String
      end

    end
  end

  describe 'get' do

    it 'lists channels' do
      VCR.use_cassette('channels-list') do
        response = Channel.get(
          'https://slack.com/api/conversations.list',
          query: { token: ENV['SLACK_TOKEN'] }
        )

        expect(response['channels']).must_be_kind_of Array
        expect(response['ok']).must_equal true
        expect(response.code).must_equal 200

      end
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

  end

end
