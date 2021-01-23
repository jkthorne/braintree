module Braintree
  class Transaction
    module Sandbox
      module Nonce
        # Generates a valid nonce that can be used to create a transaction
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-valid-nonce
        def self.valid
          "fake-valid-nonce"
        end

        # Generates a valid nonce containing no billing address information
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-valid-no-billing-address-nonce
        def self.valid_no_billing_address
          "fake-valid-no-billing-address-nonce"
        end

        # Generates a nonce representing a valid Visa card request
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-valid-visa-nonce
        def self.valid_visa
          "fake-valid-visa-nonce"
        end

        # Generates a nonce representing a valid American Express card request
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-valid-amex-nonce
        def self.valid_amex
          "fake-valid-amex-nonce"
        end

        # Generates a nonce representing a valid Mastercard request
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-valid-mastercard-nonce
        def self.valid_mastercard
          "fake-valid-mastercard-nonce"
        end

        # Generates a nonce representing a valid Discover card request
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-valid-discover-nonce
        def self.valid_discover
          "fake-valid-discover-nonce"
        end

        # Generates a nonce representing a valid JCB card request
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-valid-jcb-nonce
        def self.valid_jcb
          "fake-valid-jcb-nonce"
        end

        # Generates a nonce representing a valid Maestro card request
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-valid-maestro-nonce
        def self.valid_maestro
          "fake-valid-maestro-nonce"
        end

        # Generates a nonce representing a valid Diners Club card request
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-valid-dinersclub-nonce
        def self.valid_dinersclub
          "fake-valid-dinersclub-nonce"
        end

        # Generates a nonce representing a valid prepaid card request
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-valid-prepaid-nonce
        def self.valid_prepaid
          "fake-valid-prepaid-nonce"
        end

        # Generates a nonce representing a valid commercial card request
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-valid-commercial-nonce
        def self.valid_commercial
          "fake-valid-commercial-nonce"
        end

        # Generates a nonce representing a valid Durbin regulated card request
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-valid-durbin-regulated-nonce
        def self.valid_durbin_regulated
          "fake-valid-durbin-regulated-nonce"
        end

        # Generates a nonce representing a valid healthcare card request
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-valid-healthcare-nonce
        def self.valid_healthcare
          "fake-valid-healthcare-nonce"
        end

        # Generates a nonce representing a valid debit card request
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-valid-debit-nonce
        def self.valid_debit
          "fake-valid-debit-nonce"
        end

        # Generates a nonce representing a valid payroll card request
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-valid-payroll-nonce
        def self.valid_payroll
          "fake-valid-payroll-nonce"
        end

        # Generates a nonce representing a request for a valid card with no indicators
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-valid-no-indicators-nonce
        def self.valid_no_indicators
          "fake-valid-no-indicators-nonce"
        end

        # Generates a nonce representing a request for a valid card with unknown indicators
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-valid-unknown-indicators-nonce
        def self.valid_unknown_indicators
          "fake-valid-unknown-indicators-nonce"
        end

        # Generates a nonce representing a request for a valid card issued in the USA
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-valid-country-of-issuance-usa-nonce
        def self.valid_country_of_issuance_usa
          "fake-valid-country-of-issuance-usa-nonce"
        end

        # Generates a nonce representing a request for a valid card issued in Canada
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-valid-country-of-issuance-cad-nonce
        def self.valid_country_of_issuance_cad
          "fake-valid-country-of-issuance-cad-nonce"
        end

        # Generates a nonce representing a request for a valid card with the message 'NETWORK ONLY' from the issuing bank      end
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-valid-issuing-bank-network-only-nonce
        def self.valid_issuing_bank_network_only
          "fake-valid-issuing-bank-network-only-nonce"
        end

        # A nonce representing a Google Pay or Android Pay request
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-android-pay-nonce
        def self.android_pay
          "fake-android-pay-nonce"
        end

        # A nonce representing a Google Pay or Android Pay Visa request
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-android-pay-visa-nonce
        def self.android_pay_visa
          "fake-android-pay-visa-nonce"
        end

        # A nonce representing a Google Pay or Android Pay Mastercard request
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-android-pay-mastercard-nonce
        def self.android_pay_mastercard
          "fake-android-pay-mastercard-nonce"
        end

        # A nonce representing a Google Pay or Android Pay American Express request
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-android-pay-amex-nonce
        def self.android_pay_amex
          "fake-android-pay-amex-nonce"
        end

        # A nonce representing a Google Pay or Android Pay Discover request
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-android-pay-discover-nonce
        def self.android_pay_discover
          "fake-android-pay-discover-nonce"
        end

        # A nonce representing a PayPal via Google Pay request
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-google-pay-paypal-nonce
        def self.google_pay_paypal
          "fake-google-pay-paypal-nonce"
        end

        # A nonce representing an Apple Pay request for an American Express card number
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-apple-pay-amex-nonce
        def self.apple_pay_amex
          "fake-apple-pay-amex-nonce"
        end

        # A nonce representing an Apple Pay request for a Visa card number
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-apple-pay-visa-nonce
        def self.apple_pay_visa
          "fake-apple-pay-visa-nonce"
        end

        # A nonce representing an Apple Pay request for a Mastercard card number
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-apple-pay-mastercard-nonce
        def self.apple_pay_mastercard
          "fake-apple-pay-mastercard-nonce"
        end

        # A nonce representing an Apple Pay request for a Discover card number
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-apple-pay-discover-nonce
        def self.apple_pay_discover
          "fake-apple-pay-discover-nonce"
        end

        # A nonce representing a Local Payment Method
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-local-payment-method-nonce
        def self.local_payment_method
          "fake-local-payment-method-nonce"
        end

        # A nonce representing an unvaulted PayPal account that a customer has authorized for one-time payments via the Checkout flow. Learn more about PayPal testing options.
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-paypal-one-time-nonce
        def self.paypal_one_time
          "fake-paypal-one-time-nonce"
        end

        # A nonce representing a PayPal account that a customer has authorized for future payments via a deprecated version of the Vault flow; use fake-paypal-billing-agreement-nonce instead.
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-paypal-future-nonce
        def self.paypal_future
          "fake-paypal-future-nonce"
        end

        # A nonce representing a PayPal billing agreement that a customer has authorized via the Vault flow. Learn more about PayPal testing options.
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-paypal-billing-agreement-nonce
        def self.paypal_billing_agreement
          "fake-paypal-billing-agreement-nonce"
        end

        # A nonce representing an American Express card from Visa Checkout
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-visa-checkout-amex-nonce
        def self.visa_checkout_amex
          "fake-visa-checkout-amex-nonce"
        end

        # A nonce representing a Discover card from Visa Checkout
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-visa-checkout-discover-nonce
        def self.visa_checkout_discover
          "fake-visa-checkout-discover-nonce"
        end

        # A nonce representing a Mastercard card from Visa Checkout
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-visa-checkout-mastercard-nonce
        def self.visa_checkout_mastercard
          "fake-visa-checkout-mastercard-nonce"
        end

        # A nonce representing a Visa card from Visa Checkout
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-visa-checkout-visa-nonce
        def self.visa_checkout_visa
          "fake-visa-checkout-visa-nonce"
        end

        # A nonce representing an American Express card from Masterpass
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-masterpass-amex-nonce
        def self.masterpass_amex
          "fake-masterpass-amex-nonce"
        end

        # A nonce representing a Discover card from Masterpass
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-masterpass-discover-nonce
        def self.masterpass_discover
          "fake-masterpass-discover-nonce"
        end

        # A nonce representing a Mastercard card from Masterpass
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-masterpass-mastercard-nonce
        def self.masterpass_mastercard
          "fake-masterpass-mastercard-nonce"
        end

        # A nonce representing a Visa card from Masterpass
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-masterpass-visa-nonce
        def self.masterpass_visa
          "fake-masterpass-visa-nonce"
        end

        # A nonce representing a Venmo Account
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-venmo-account-nonce
        def self.venmo_account
          "fake-venmo-account-nonce"
        end

        # A nonce representing a Visa card from Samsung Pay
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#nonce_tokensam_fake_visa
        def self.tokensam_visa
          "tokensam_fake_visa"
        end

        # A nonce representing a Mastercard card from Samsung Pay
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#nonce_tokensam_fake_mastercard
        def self.tokensam_mastercard
          "tokensam_fake_mastercard"
        end

        # A nonce representing an American Express card from Samsung Pay
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#nonce_tokensam_fake_american_express
        def self.tokensam_american_express
          "tokensam_fake_american_express"
        end

        # A nonce representing a request for a Visa card that was declined by the processor
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-processor-declined-visa-nonce
        def self.processor_declined_visa
          "fake-processor-declined-visa-nonce"
        end

        # A nonce representing a request for a Mastercard that was declined by the processor
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-processor-declined-mastercard-nonce
        def self.processor_declined_mastercard
          "fake-processor-declined-mastercard-nonce"
        end

        # A nonce representing a request for a American Express card that was declined by the processor
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-processor-declined-amex-nonce
        def self.processor_declined_amex
          "fake-processor-declined-amex-nonce"
        end

        # A nonce representing a request for a Discover card that was declined by the processor
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-processor-declined-discover-nonce
        def self.processor_declined_discover
          "fake-processor-declined-discover-nonce"
        end

        # A nonce representing a request for a Diners Club card that was declined by the processor
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-processor-declined-dinersclub-nonce
        def self.processor_declined_dinersclub
          "fake-processor-declined-dinersclub-nonce"
        end

        # A nonce representing a request for a JCB card that was declined by the processor
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-processor-failure-jcb-nonce
        def self.processor_failure_jcb
          "fake-processor-failure-jcb-nonce"
        end

        # A nonce representing a Luhn-invalid card
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-luhn-invalid-nonce
        def self.luhn_invalid
          "fake-luhn-invalid-nonce"
        end

        # A nonce that has already been consumed
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-consumed-nonce
        def self.consumed
          "fake-consumed-nonce"
        end

        # A nonce representing a 3-digit CVV with a CVV response of M (matches)
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-three-digit-cvv-only-nonce
        def self.three_digit_cvv_only
          "fake-three-digit-cvv-only-nonce"
        end

        # A nonce representing a 3-digit CVV with a CVV response of N (does not match)
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-three-digit-cvv-only-n-response-nonce
        def self.three_digit_cvv_only_n_response
          "fake-three-digit-cvv-only-n-response-nonce"
        end

        # A nonce representing a 3-digit CVV with a CVV response of U (not verified)
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-three-digit-cvv-only-u-response-nonce
        def self.three_digit_cvv_only_u_response
          "fake-three-digit-cvv-only-u-response-nonce"
        end

        # A nonce representing a 3-digit CVV with a CVV response of S (issuer does not participate)
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-three-digit-cvv-only-s-response-nonce
        def self.three_digit_cvv_only_s_response
          "fake-three-digit-cvv-only-s-response-nonce"
        end

        # A nonce representing a 4-digit CID with a CVV response of M (matches)
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-four-digit-cvv-only-nonce
        def self.four_digit_cvv_only
          "fake-four-digit-cvv-only-nonce"
        end

        # A nonce representing a 4-digit CID with a CVV response of N (does not match)
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-four-digit-cvv-only-n-response-nonce
        def self.four_digit_cvv_only_n_response
          "fake-four-digit-cvv-only-n-response-nonce"
        end

        # A nonce representing a 4-digit CID with a CVV response of U (not verified)
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-four-digit-cvv-only-u-response-nonce
        def self.four_digit_cvv_only_u_response
          "fake-four-digit-cvv-only-u-response-nonce"
        end

        # A nonce representing a 4-digit CID with a CVV response of S (issuer does not participate)
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-four-digit-cvv-only-s-response-nonce
        def self.four_digit_cvv_only_s_response
          "fake-four-digit-cvv-only-s-response-nonce"
        end

        # A nonce or three_d_secure_authentication_id representing a full 3D Secure authentication
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-three-d-secure-visa-full-authentication-nonce
        def self.three_d_secure_visa_full_authentication
          "fake-three-d-secure-visa-full-authentication-nonce"
        end

        # A nonce or three_d_secure_authentication_id representing a 3D secure error where the cardholder enrollment lookup request timed out
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-three-d-secure-visa-lookup-timeout-nonce
        def self.three_d_secure_visa_lookup_timeout
          "fake-three-d-secure-visa-lookup-timeout-nonce"
        end

        # A nonce or three_d_secure_authentication_id representing a 3D Secure authentication where the cardholder was enrolled but failed signature verification
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-three-d-secure-visa-failed-signature-nonce
        def self.three_d_secure_visa_failed_signature
          "fake-three-d-secure-visa-failed-signature-nonce"
        end

        # A nonce or three_d_secure_authentication_id representing a 3D Secure scenario where the cardholder was enrolled but failed authentication
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-three-d-secure-visa-failed-authentication-nonce
        def self.three_d_secure_visa_failed_authentication
          "fake-three-d-secure-visa-failed-authentication-nonce"
        end

        # A nonce or three_d_secure_authentication_id representing a 3D Secure authentication through the card brand's Attempts server because the issuer's authentication server is unavailable
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-three-d-secure-visa-attempts-non-participating-nonce
        def self.three_d_secure_visa_attempts_non_participating
          "fake-three-d-secure-visa-attempts-non-participating-nonce"
        end

        # A nonce or three_d_secure_authentication_id representing a 3D Secure authentication where the cardholder was not enrolled
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-three-d-secure-visa-not-enrolled-nonce
        def self.three_d_secure_visa_not_enrolled
          "fake-three-d-secure-visa-not-enrolled-nonce"
        end

        # A nonce or three_d_secure_authentication_id representing a 3D Secure error where enrollment lookup is not available
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-three-d-secure-visa-unavailable-nonce
        def self.three_d_secure_visa_unavailable
          "fake-three-d-secure-visa-unavailable-nonce"
        end

        # A nonce or three_d_secure_authentication_id representing a 3D Secure error during the cardholder enrollment lookup
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-three-d-secure-visa-mpi-lookup-error-nonce
        def self.three_d_secure_visa_mpi_lookup_error
          "fake-three-d-secure-visa-mpi-lookup-error-nonce"
        end

        # A nonce or three_d_secure_authentication_id representing a 3D Secure error during authentication
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-three-d-secure-visa-mpi-authenticate-error-nonce
        def self.three_d_secure_visa_mpi_authenticate_error
          "fake-three-d-secure-visa-mpi-authenticate-error-nonce"
        end

        # A nonce or three_d_secure_authentication_id representing a 3D Secure error where the cardholder is enrolled but authentication is not available
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-three-d-secure-visa-authentication-unavailable-nonce
        def self.three_d_secure_visa_authentication_unavailable
          "fake-three-d-secure-visa-authentication-unavailable-nonce"
        end

        # A nonce or three_d_secure_authentication_id representing a scenario where 3D Secure must be bypassed to prevent rejections during lookup or authentication service outages
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-three-d-secure-visa-bypassed-authentication-nonce
        def self.three_d_secure_visa_bypassed_authentication
          "fake-three-d-secure-visa-bypassed-authentication-nonce"
        end

        # A nonce or three_d_secure_authentication_id representing a 3D Secure 2 successful authentication that did not require a challenge
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-three-d-secure-two-visa-successful-frictionless-authentication-nonce
        def self.three_d_secure_two_visa_successful_frictionless_authentication
          "fake-three-d-secure-two-visa-successful-frictionless-authentication-nonce"
        end

        # A nonce or three_d_secure_authentication_id representing a 3D Secure 2 successful authentication that required a challenge
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-three-d-secure-two-visa-successful-step-up-authentication-nonce
        def self.three_d_secure_two_visa_successful_step_up_authentication
          "fake-three-d-secure-two-visa-successful-step-up-authentication-nonce"
        end

        # A nonce or three_d_secure_authentication_id representing a 3D Secure 2 error during the cardholder enrollment lookup
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-three-d-secure-two-visa-error-on-lookup-nonce
        def self.three_d_secure_two_visa_error_on_lookup
          "fake-three-d-secure-two-visa-error-on-lookup-nonce"
        end

        # A nonce or three_d_secure_authentication_id representing a 3D secure 2 error where the cardholder enrollment lookup request timed out
        #
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#fake-three-d-secure-two-visa-timeout-on-lookup-nonce
        def self.three_d_secure_two_visa_timeout_on_lookup
          "fake-three-d-secure-two-visa-timeout-on-lookup-nonce"
        end
      end
    end
  end
end
