module Braintree
  class Transaction
    module Sandbox
      def self.amount
        Amount
      end
    end

    def self.sandbox
      Sandbox
    end

    def self.factory
      TransactionFactory
    end
  end
end
