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

end