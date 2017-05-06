require_relative '../../enthereum_snapshot'
require 'rspec'
require 'rack/test'

describe 'The accounts endpoint' do
  include Rack::Test::Methods

  def app
    EthereumSnapshot.app
  end

  it "responds to /accounts" do
    get "/accounts"
    expect(last_response.ok?).to be true
  end

  it "responds when /accounts posted with valid address" do
    post "/accounts/0x2b9c4e2ad6f1e7bd43365abb99faa1867706ea9c"
    expect(last_response.ok?).to be true
  end

  it "responds when /accounts posted with valid address without prefix" do
    post "/accounts/2b9c4e2ad6f1e7bd43365abb99faa1867706ea9c"
    expect(last_response.ok?).to be true
  end
end