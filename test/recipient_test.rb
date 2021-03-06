require_relative 'test_helper'
require_relative '../lib/recipient'

describe 'Recipient' do
  before do
    @recipient = Recipient.new("987654321", "test person")
  end

  describe 'constructor' do
    it 'creates instance of Recipient' do
      expect(@recipient).must_be_kind_of Recipient
    end

    it 'check attribute data types' do
      expect(@recipient.name).must_be_kind_of String
      expect(@recipient.name).must_equal "test person"
      expect(@recipient.slack_id).must_be_kind_of String
      expect(@recipient.slack_id).must_equal "987654321"
    end

    it "must respond to its attr_reader" do
      expect(@recipient).must_respond_to :slack_id
      expect(@recipient).must_respond_to :name
    end

    it "raises an error if slack_id or name is nil" do
      # slack_id is empty
      expect {
        Recipient.new("", "slackbot")
      }.must_raise ArgumentError

      # name is empty
      expect {
        Recipient.new("987654321", "")
      }.must_raise ArgumentError

    end

  end

  describe "self.get" do
    it " returns a response" do
      VCR.use_cassette('recipient-get') do
        query = {token: ENV['SLACK_TOKEN']}
        url = 'https://slack.com/api/conversations.list'
        response = Recipient.get(url, query: query)

        expect(response['ok']).must_equal true
      end
    end

    it "must be an instance of HTTParty " do
      VCR.use_cassette('recipient-get') do
        query = {token: ENV['SLACK_TOKEN']}
        url = 'https://slack.com/api/conversations.list'
        response = Recipient.get(url, query: query)

        expect(response).must_be_kind_of HTTParty::Response
        end
    end

    it "raises a SlackApiError when paramater input is invalid " do
      VCR.use_cassette('recipient-get negative') do
        query2 = {token: ENV['SLACK_TOKEN']}
        url_bogus = 'https://slack.com/api/bogus'

        expect {
          Recipient.get(url_bogus, query: query2)
        }.must_raise SlackAPIError

        expect {
          Recipient.get(url_bogus, query: {token: ENV['BOGUS']})
        }.must_raise SlackAPIError
      end
    end
  end

  describe 'list_all' do
    it 'raises an error if invoked directly (without subclassing)' do
      expect do
        Recipient.list_all
      end.must_raise NotImplementedError
    end
  end
  
  describe 'details' do
    it 'raises an error if invoked directly (without subclassing)' do
      expect do
        @recipient.details
      end.must_raise NotImplementedError
    end
  end

  describe "send_message" do
    before do
      @valid_recipient = Recipient.new('C01C0H7R9QS', 'random')
    end

    it "has a send_message method" do
      expect(@recipient).must_respond_to :send_message
    end

    it 'error when API call fails' do
      VCR.use_cassette('nominal negative') do
        expect {
          @recipient.send_message("testing that I can send text")
        }.must_raise SlackAPIError
      end
    end

    it "sends the message if recipient is valid" do
      VCR.use_cassette('nominal positive') do
        expect(@valid_recipient.send_message("testing that I can send text")).must_equal true
      end
    end
  end
end