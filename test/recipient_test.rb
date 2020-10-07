require_relative 'test_helper'
require_relative '../lib/recipient'
# if we use a module, we will have access to everything want - won't
# need to import/require-relative for each file

# how do we pull from the API?
#KEY = (how to call on the key hidden in .env?)
#URL = ""

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
    it 'raises an error if invoked directly (without subclassing' do
      expect {
        Recipient.list_all
      }.must_raise NotImplementedError

    end
    describe 'get' do

    end

  end

end