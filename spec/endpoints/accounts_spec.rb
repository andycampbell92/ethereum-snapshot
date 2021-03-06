require_relative '../../enthereum_snapshot'
require 'rspec'
require 'rack/test'
require 'oj'

describe "/accounts endpoint" do
  include Rack::Test::Methods

  def app
    EthereumSnapshot.app
  end

  before(:each) do
    DB[Account.table_name].delete
    @seeded_accounts = [
      {'address' => '0x2b9c4e2ad6f1e7bd43365abb99faa1867706ea9c', 'balance' => 500000000000000000},
      {'address' => '0xe0498570303d14456c71eb7f6f057ea149a425c6', 'balance' => 600000000000000000},
      {'address' => '0x8eeec35015baba2890e714e052dfbe73f4b752f9', 'balance' => 700000000000000000},
      {'address' => '0xfb663039763f61506f66158720f72794eddb1cc0', 'balance' => 800000000000000000}
    ]

    Account.multi_insert(@seeded_accounts)

    @seeded_accounts.each {|account| account['ether'] = account['balance']/1000000000000000000.0}
  end

  describe "get /accounts" do
    it "responds with ok" do
      get "/accounts"
      expect(last_response.ok?).to be true
    end

    it "responds with a list of all accounts in the database" do
      get "/accounts"
      expect(Oj.load(last_response.body)).to eq @seeded_accounts
    end
  end

  describe "get /accounts/:address" do
    it "responds with ok when given valid address" do
      to_get = @seeded_accounts[0]
      get "/accounts/#{to_get['address']}"
      expect(last_response.ok?).to be true
    end

    it "responds with corresponding account when provided with address" do
      to_get = @seeded_accounts[1]
      get "/accounts/#{to_get['address']}"
      expect(Oj.load(last_response.body)).to eq to_get
    end

    it "responds with not_found when non existent address provided" do
      get "/accounts/0x111111111111111111115abb99faa1867706ea9c"
      expect(last_response.not_found?).to be true
    end

    it "responds with sensible message when non existent address provided" do
      get "/accounts/0x111111111111111111115abb99faa1867706ea9c"
      expect(Oj.load(last_response.body)['message']).to eq "An account with that address was not found in cache"
    end

    it "responds with sensible message when invalid address provided" do
      get "/accounts/0x111111111111111111115abb99faa1867706ea9r"
      expect(Oj.load(last_response.body)['message']).to eq "The address provided was invalid"
    end

    it "responds with ok to /accounts/:address get with valid address without prefix" do
      to_get = @seeded_accounts[2]
      get "/accounts/#{to_get['address'][2..-1]}"
      expect(Oj.load(last_response.body)).to eq to_get
    end
  end

  # TODO Mock response from etherchain.org use this to test for correct behaviour when there are connection errors
  describe "post /accounts/:address" do
    it "responds with ok when provided with valid address" do
      post "/accounts/0x2b9c4e2ad6f1e7bd43365abb99faa1867706ea9c"
      expect(last_response.ok?).to be true
    end

    it "responds with ok when provided with valid address without prefix" do
      post "/accounts/2b9c4e2ad6f1e7bd43365abb99faa1867706ea9c"
      expect(last_response.ok?).to be true
    end

    it "should respond with a 404 when provided with a blank address" do
      post "/accounts/0xbb3e1a9b1a5e86503f4766500153f75ed0870d45"
      expect(last_response.not_found?).to be true
    end
  end
end