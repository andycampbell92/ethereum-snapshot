require_relative "models"
require "roda"
require "oj"
require "rest-client"


class EthereumSnapshot < Roda
  plugin :json, :serializer=>proc{|o| Oj.dump(o, :mode => :strict)}
  
  route do |r|
    r.on "accounts" do
      whitelist = [:address, :balance]
      r.is do
        r.get do
          Account.select(*whitelist).map do |o| 
            values = o.values
            values['ether'] = o.ether_balance
            values
          end
        end
      end


      r.is ":address" do |address|
        r.get do
          validated_address = Account.validate_address(address)
          if validated_address.nil?
            response.status = 400
            {"message" => "The address provided was invalid"}
          else
            found_accounts = Account.select(*whitelist).where(address: validated_address).limit(1).map do |o|
              values = o.values
              values['ether'] = o.ether_balance
              values
            end
            if found_accounts.length == 0
              response.status = 404
              {"message" => "An account with that address was not found in cache"}
            else
              found_accounts[0]
            end
          end
        end

        r.post do
          validated_address = Account.validate_address(address)
          if validated_address.nil?
            response.status = 400
            {"message" => "The address provided was invalid"}
          else
            begin
              ether_data = RestClient::Request.execute(:method => :get, :url => "https://etherchain.org/api/account/#{validated_address}", :timeout => 60)
              account_data = Oj.load(ether_data.body)
              if account_data['data'].empty?
                 response.status = 404
                 {"message" => "There was no data associated with the account provided"}
              else
                balance = account_data['data'][0]['balance']
                account = Account.find_or_create(address: validated_address)
                account.balance = balance
                account.save
                {"message" => "cache updated"}
              end
            rescue RestClient::ExceptionWithResponse => e
              response.status = 400
              {"message" => "There was a problem with your request"}
            rescue Exception => e
              response.status = 403
              {"message" => "There was a problem connecting to etherchain please try again later"}
            end
          end
        end

      end
    end
  end
end