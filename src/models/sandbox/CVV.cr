module Braintree
  class Transaction
    module Sandbox
      module CVV
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#cvv-200
        def self.does_not_match
          200
        end
        
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#cvv-201
        def self.not_verified
          201
        end

        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#cvv-301
        def self.issuer_does_not_participate
          301
        end

        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#cvv-no-value-passed
        def self.not_provided
          nil
        end

        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#https://developers.braintreepayments.com/reference/general/testing/ruby#cvv-any-other-value
        def self.matches
          rand(100..199)
        end
      end

      module CID
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#cvv-2000
        def self.does_not_match
          2000
        end

        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#cvv-2011
        def self.not_verified
          2011
        end

        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#cvv-3011
        def self.issuer_does_not_participate
          3011
        end

        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#cvv-no-value-passed
        def self.not_provided
          nil
        end

        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#https://developers.braintreepayments.com/reference/general/testing/ruby#cvv-any-other-value
        def self.matches
          rand(100..199)
        end
      end

      module AVS
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#billing-postal-code-30000
        def self.system_error
          30000
        end

        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#billing-postal-code-30001
        def self.issuing_bank_does_not_support_avs
          30001
        end

        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#billing-postal-code-any-other-value
        def self.blank
          rand(3002..3999)
        end

        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#billing-postal-code-20000
        def self.postal_code_does_not_match
          20000
        end

        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#billing-postal-code-20001
        def self.postal_code_does_not_match
          20001
        end

        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#billing-postal-code-no-value-passed
        def self.postal_code_not_provided
          nil
        end

        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#billing-postal-code-any-other-value
        def self.postal_code_matches
          rand(2002..2999)
        end

        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#billing-street-address-street-number-is-200-eg-200-n-main-st
        def self.street_address_does_not_match
          "200 N Main St"
        end

        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#billing-street-address-street-number-is-201-eg-201-n-main-st
        def self.street_address_not_verified
          "201 N Main St"
        end

        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#billing-street-address-no-value-passed
        def self.street_address_not_provided
          nil
        end

        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#billing-street-address-any-other-value
        def self.matches
          "#{rand(202..299)} N Main St"
        end
      end
    end
  end
end
