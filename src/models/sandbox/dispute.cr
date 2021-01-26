module Braintree
  class Transaction
    module Sandbox
      module Dispute
        VISA_FRAUD_1   = 83.00
        VISA_FRAUD_2   = 10.40
        VISA_FRAUD_3   = 13.10
        DISCOVER_FRAUD = 70.30
        FRAUD_AMOUNT   = StaticArray[VISA_FRAUD_1, VISA_FRAUD_2, VISA_FRAUD_3, DISCOVER_FRAUD]

        def self.card_number
          "4023898493988028"
        end

        def self.fraud_amount
          FRAUD_AMOUNT.sample
        end

        def self.compelling_evidence
          "compelling_evidence"
        end

        def self.losing_evidence
          "losing_evidence"
        end
      end
    end
  end
end
