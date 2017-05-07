require_relative "models"
require "roda"
require "oj"


class EthereumSnapshot < Roda
  plugin :json, :serializer=>proc{|o| Oj.dump(o, :mode => :strict)}
  
  route do |r|
    r.on "accounts" do
      whitelist = [:address, :balance]
      r.is do
        r.get do
          Account.select(*whitelist).map {|o| o.values}
        end
      end


      r.is ":address" do |address|
        r.get do
          validated_address = Account.validate_address(address)
          if validated_address.nil?
            response.status = 400
            {"message" => "The address provided was invalid"}
          else
            found_accounts = Account.select(*whitelist).where(address: validated_address).limit(1).map {|o| o.values}
            if found_accounts.length == 0
              response.status = 404
              {"message" => "An account with that address was not found in cache"}
            else
              found_accounts[0]
            end
          end
        end

        r.post do
          "post accounts"
        end

      end
    end
  end
end