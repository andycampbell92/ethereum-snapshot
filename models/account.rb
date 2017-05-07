class Account < Sequel::Model
  @@valid_address_lengths = [40, 42]

  def self.validate_address(address)
    if @@valid_address_lengths.member? address.length
      non_prefixed = address.length == 42 ? address[2..-1] : address
      # if non_prefixed is hex
      if !non_prefixed[/\H/]
        return "0x" + non_prefixed
      end
    end
  end
end