require_relative 'test_helper'
require_relative '../lib/user'
require_relative '../lib/recipient'

describe 'User' do
  describe 'create instance of User for tests' do
    before do
      @channel = User.new(
        slack_id: '987654321',
        name: 'Ada Bot',
        real_name: 'Ada Lovelace',
        status_text: 'working',
        status_emoji: ':confused-dog:'
      )
    end

    describe 'constructor' do
      it 'creates instance of User' do
        expect(@channel).must_be_kind_of User
      end

      it 'check attribute data types' do
        expect(@channel.name).must_be_kind_of String
        expect(@channel.slack_id).must_be_kind_of String
        expect(@channel.real_name).must_be_kind_of String
        expect(@channel.status_text).must_be_kind_of String
        expect(@channel.status_emoji).must_be_kind_of String
      end

    end
  end
  
  describe 'get' do

    it 'lists users' do
      VCR.use_cassette('users-list') do
        response = User.get(
          'https://slack.com/api/users.list',
          query: { token: ENV['SLACK_TOKEN'] }
        )

        expect(response['members']).must_be_kind_of Array
        expect(response['ok']).must_equal true
        expect(response.code).must_equal 200

      end
    end

    #TODO: this test is not working:
    it 'error when API call fails' do

      VCR.use_cassette('users-list') do
        expect{
          User.get(
          'https://slack.com/api/users.no_one_lives_here',
          query: { token: ENV['SLACK_TOKEN'] }
          )
        }.must_raise SlackApiError
       
      end
    end

  end 
  
end
