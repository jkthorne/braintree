module Braintree
  class Transaction
    module Sandbox
      def self.amount
        Amount
      end
    end
  end
end
