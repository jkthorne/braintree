module Braintree
  class Transaction
    module Sandbox
      module BankRoutingNumbers
        ROUNTING_NUMBER_1 = "071101307"
        ROUNTING_NUMBER_2 = "071000013"
        ROUNTING_NUMBERS  = StaticArray[ROUNTING_NUMBER_1, ROUNTING_NUMBER_2]

        # Bank routing numbers must pass a checksum, much like credit card numbers. The following routing numbers are valid, and can be passed to the sandbox:
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#bank-routing-numbers
        def self.routing_number
          ROUNTING_NUMBERS.sample
        end
      end
    end
  end
end
