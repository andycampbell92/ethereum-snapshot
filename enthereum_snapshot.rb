require "roda"

class EthereumSnapshot < Roda
  route do |r|
    r.on "accounts" do
      r.is do
        r.get do
          "hello from accounts"
        end
      end

      r.is ":address" do |address|
        r.post do
          "#{address}"
        end

        r.get do
          "existing user  #{address}"
        end
      end
    end
  end
end