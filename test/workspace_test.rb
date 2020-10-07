require_relative 'test_helper'
require_relative '../lib/workspace'


describe "Workspace" do
  before do
    VCR.use_cassette("making new workspace") do
      @workspace = Workspace.new
    end
  end
  describe "constructor" do

  end

  describe "select_user method" do
    it "responds to the method call" do
      expect(@workspace).must_respond_to :select_user
    end

    it "returns the correct user instance" do
      expect(@workspace.select_user('USLACKBOT')).must_be_kind_of User
      # another expect

    end





  end

end