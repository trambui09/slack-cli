require_relative 'test_helper'
require_relative '../lib/user'
require_relative '../lib/recipient'

describe 'User class ' do
  before do
    @user = User.new(
        slack_id: 'USLACKBOT',
        name: 'slackbot',
        real_name: 'Slackbot',
        status_text: '',
        status_emoji: ''
    )

    VCR.use_cassette("list members") do
      @response = User.list_all
    end
  end

  describe 'constructor' do
    it 'creates instance of User' do
      expect(@user).must_be_kind_of User
    end

    it 'check attribute data types' do
      expect(@user.name).must_be_kind_of String
      expect(@user.name).must_equal 'slackbot'
      expect(@user.slack_id).must_be_kind_of String
      expect(@user.slack_id).must_equal 'USLACKBOT'
      expect(@user.real_name).must_be_kind_of String
      expect(@user.real_name).must_equal 'Slackbot'
      expect(@user.status_text).must_be_kind_of String
      expect(@user.status_emoji).must_be_kind_of String
    end

  end

  describe "details" do
    it " returns a string with the details on the user" do
      expect(@user.details).must_equal "Slack ID: #{@user.slack_id} \nName: #{@user.name}"
    end
  end


  describe 'list_all' do
    it 'lists users' do
      VCR.use_cassette('users-list') do
        response = User.get(
          'https://slack.com/api/users.list',
          query: { token: ENV['SLACK_TOKEN'] }
        )

        expect(response['members']).must_be_kind_of Array
        expect(response['ok']).must_equal true
        expect(response.code).must_equal 200

        @users = User.list_all

        expect(@users.length).must_equal response.length

        # the first user is matched
        expect(response['members'].first['id']).must_equal @users.first.slack_id
        expect(response['members'].first['name']).must_equal @users.first.name
        expect(response['members'].first['real_name']).must_equal @users.first.real_name

      end
    end

    it 'error when API call fails' do
      VCR.use_cassette('API-fail') do
        expect {
          User.get(
          'https://slack.com/api/users.no_one_lives_here',
          query: { token: ENV['SLACK_TOKEN'] }
        )
        }.must_raise SlackAPIError

      end
    end

    it "rescues the error - doesn't throw an error" do
      VCR.use_cassette('rescue-user-error') do
        expect(User.list_all).must_be_nil
      end
    end
  end
end
