require_relative '../../enthereum_snapshot'
require 'rspec'

describe "accounts model" do
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

  end
end