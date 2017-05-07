require_relative '../../enthereum_snapshot'
require 'rspec'
require 'rack/test'
require 'oj'

describe 'The accounts endpoint' do
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
  end

  it "responds with ok to /accounts" do
    get "/accounts"
    expect(last_response.ok?).to be true
  end

  it "responds with a list of all accounts in the database" do
    get "/accounts"
    expect(Oj.load(last_response.body)).to eq @seeded_accounts
  end

  it "responds with ok when /accounts/:address posted with valid address" do
    post "/accounts/0x2b9c4e2ad6f1e7bd43365abb99faa1867706ea9c"
    expect(last_response.ok?).to be true
  end

  it "responds with ok when /accounts/:address posted with valid address without prefix" do
    post "/accounts/2b9c4e2ad6f1e7bd43365abb99faa1867706ea9c"
    expect(last_response.ok?).to be true
  end

  it "responds with ok to /accounts/:address get with valid address" do
    get "/accounts/0x2b9c4e2ad6f1e7bd43365abb99faa1867706ea9c"
    expect(last_response.ok?).to be true
  end

  it "responds with ok to /accounts/:address get with valid address without prefix" do
    get "/accounts/2b9c4e2ad6f1e7bd43365abb99faa1867706ea9c"
    expect(last_response.ok?).to be true
  end
end