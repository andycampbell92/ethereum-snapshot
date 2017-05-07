require_relative '../../enthereum_snapshot'
require 'rspec'

describe "accounts model" do
  before(:each) do
    DB[Account.table_name].delete
  end
  
  describe "self.validate_address" do
    it "should return a prefixed string of the valid address when passed a valid addresss with prefix" do
      prefixed_address = "0x2b9c4e2ad6f1e7bd43365abb99faa1867706ea9c"
      expect(Account.validate_address(prefixed_address)).to eq prefixed_address
    end

    it "should return a prefixed string of the valid address when passed a valid addresss without prefix" do
      non_prefixed_address = "2b9c4e2ad6f1e7bd43365abb99faa1867706ea9c"
      expect(Account.validate_address(non_prefixed_address)).to eq("0x" + non_prefixed_address)
    end

    it "Should return nil if the string provided is not hexidecimal" do
      non_hex = "0x2b9c4e2ad6f1e7bd43365abb99faa1867706ea9r"
      expect(Account.validate_address(non_hex)).to be nil
    end

    it "Should return nil if the string provided is not a valid length" do
      incorrect_len = "0x2b9c4e2ad6f1e7bd43365abb99faa1867706ea9c1"
      expect(Account.validate_address(incorrect_len)).to be nil
    end

    it "Should return nil if address provided is 41 chars long" do
      incorrect_len = "02b9c4e2ad6f1e7bd43365abb99faa1867706ea9c"
      expect(Account.validate_address(incorrect_len)).to be nil
    end
  end

  describe "ether_balance" do
    it "should return a valid balance in ether for a created record" do
      account = Account.create(address: "2b9c4e2ad6f1e7bd43365abb99faa1867706ea9c", balance: 43212349912)
      expect(account.ether_balance).to eq 0.000000043212349912
    end
  end
end