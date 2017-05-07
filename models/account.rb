class Account < Sequel::Model
  def self.validate_address(address)
    if address.length.between?(40, 42)
      non_prefixed = address.length == 42 ? address[2..-1] : address
      # if non_prefixed is hex
      if !non_prefixed[/\H/]
        return "0x" + non_prefixed
      end
    end
  end
end