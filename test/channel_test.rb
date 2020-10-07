require_relative 'test_helper'
require_relative '../lib/channel'
require_relative '../lib/recipient'

describe 'Channel' do
  describe 'create instance of Channel for tests' do
    before do
      @channel = Channel.new(
        slack_id: '987654321',
        name: 'Ada Bot',
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

  describe '' do

  end

end
