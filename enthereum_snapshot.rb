require_relative "models"
require "roda"
require "oj"


class EthereumSnapshot < Roda
  plugin :json, :classes=>[Array, Hash], :serializer=>proc{|o| Oj.dump(o, :mode => :strict)}
  
  route do |r|
    r.on "accounts" do
      whitelist = [:address, :balance]
      r.is do
        r.get do
          Account.select(*whitelist).map {|o| o.values}
        end
      end

      r.is ":address" do |address|
        r.post do
          "post accounts"
        end

        r.get do
          "existing user  #{address}"
        end
      end
    end
  end
end