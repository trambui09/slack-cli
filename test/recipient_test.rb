require_relative 'test_helper'

# how do we pull from the API?

describe 'Recipient' do
  before do
    # @recipient = create instance of receipient for tests
  end

  describe 'constructor' do
    it 'creates instance of Recipient' do
      expect(@recipient).must_be_kind_of Recipient
    end

    it 'check attribute data types' do
      expect(@recipient.name).must_be_kind_of #data type
      expect(@recipient.slack_id).must_be_kind_of #data type
    end

  end

  describe 'list_all' do
    it 'raises an error if invoked directly (without subclassing' do
      expect {
        Recipient.list_all
      }.must_raise NotImplementedError

    end

    # it '' do
    #
    # end
  end

end