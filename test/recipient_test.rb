require_relative 'test_helper'
require_relative '../lib/recipient'
#TODO: .get check? any other methods to test here

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
      expect(@recipient.slack_id).must_be_kind_of String
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

      # VCR.use_cassette('API-fail') do
      #   expect {
      #     Recipient.post(
      #       'https://slack.com/api/chat.postMessage',
      #       headers: { 'Content-Type' => 'application/x-www-form-urlencoded' },
      #       body: {
      #         token: ENV['SLACK_TOKEN'],
      #         text: 'testing',
      #         channel: 'bogus'}
      #     )
      #   }.must_raise SlackAPIError
      #   end

    end

    it "sends the message if recipient is valid" do

      VCR.use_cassette('nominal positive') do
        expect(@valid_recipient.send_message("testing that I can send text")).must_equal true
      end

    end

  end

end