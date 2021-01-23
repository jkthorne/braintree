module Braintree
  class Transaction
    module Sandbox
      module Card
        # You can use the following test card numbers in the sandbox to simulate Advanced Fraud Management Tools or risk threshold rules rejecting a request.
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fraud-tools
        def self.gateway_rejected_fraud
          4000111111111511
        end

        # You can use the following test card numbers in the sandbox to simulate Advanced Fraud Management Tools or risk threshold rules rejecting a request.
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fraud-tools
        def self.gateway_rejected_risk_threshold
          4111130000000003
        end
      end

      module Nonce
        # A nonce representing a card that will be gateway rejected by Kount
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-gateway-rejected-kount-nonce
        def self.gateway_rejected_kount
          "fake-gateway-rejected-kount-nonce"
        end
        # A nonce representing a card that will be gateway rejected by your risk threshold rules
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-gateway-rejected-risk-thresholds-nonce
        def self.gateway_rejected_risk_thresholds
          "fake-gateway-rejected-risk-thresholds-nonce"
        end
      end
    end
  end
end
