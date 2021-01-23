module Braintree
  class Transaction
    module Sandbox
      module Amount
        # Generate an amount for an authorized transaction
        #
        # This transaction will also be settled
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#amount-001-199999
        def self.authorized
          rand(
            [
              0.01..1999.99,
              3001.00..4000.99,
              5002.00..9999.99
            ].sample
          )
        end

        # Generate an amount for a Soft declined transaction  Do Not Honor
        #
        # The customer's bank is unwilling to accept the transaction. The customer will need to contact their bank for more details regarding this generic decline.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2000
        def self.do_not_honor
          rand(2000.00..2000.99)
        end
        

        # Generate an amount for a Soft declined transaction  Insufficient Funds
        #
        # The account did not have sufficient funds to cover the transaction amount at the time of the transaction – subsequent attempts at a later date may be successful.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2001
        def self.insufficient_funds
          rand(2001.00..2001.99)
        end
        

        # Generate an amount for a Soft declined transaction  Limit Exceeded
        #
        # The attempted transaction exceeds the withdrawal limit of the account. The customer will need to contact their bank to change the account limits or use a different payment method.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2002
        def self.limit_exceeded
          rand(2002.00..2002.99)
        end
        

        # Generate an amount for a Soft declined transaction  Cardholder's Activity Limit Exceeded
        #
        # The attempted transaction exceeds the activity limit of the account. The customer will need to contact their bank to change the account limits or use a different payment method.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2003
        def self.cardholders_activity_limit_exceeded
          rand(2003.00..2003.99)
        end
        

        # Generate an amount for a Hard declined transaction  Expired Card
        #
        # Card is expired. The customer will need to use a different payment method.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2004
        def self.expired_card
          rand(2004.00..2004.99)
        end
        

        # Generate an amount for a they will need to contact their bank. declined transaction  Invalid Credit Card Number
        #
        # The customer entered an invalid payment method or made a typo in their credit card information. Have the customer correct their payment information and attempt the transaction again – if the decline persists
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2005
        def self.invalid_credit_card_number
          rand(2005.00..2005.99)
        end
        

        # Generate an amount for a they will need to contact their bank. declined transaction  Invalid Expiration Date
        #
        # The customer entered an invalid payment method or made a typo in their card expiration date. Have the customer correct their payment information and attempt the transaction again – if the decline persists
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2006
        def self.invalid_expiration_date
          rand(2006.00..2006.99)
        end
        

        # Generate an amount for a Hard declined transaction  No Account
        #
        # The submitted card number is not on file with the card-issuing bank. The customer will need to contact their bank.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2007
        def self.no_account
          rand(2007.00..2007.99)
        end
        

        # Generate an amount for a the customer will need to contact their bank. declined transaction  Card Account Length Error
        #
        # The submitted card number does not include the proper number of digits. Have the customer attempt the transaction again – if the decline persists
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2008
        def self.card_account_length_error
          rand(2008.00..2008.99)
        end
        

        # Generate an amount for a Hard declined transaction  No Such Issuer
        #
        # This decline code could indicate that the submitted card number does not correlate to an existing card-issuing bank or that there is a connectivity error with the issuer. The customer will need to contact their bank for more information.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2009
        def self.no_such_issuer
          rand(2009.00..2009.99)
        end
        

        # Generate an amount for a the customer will need to contact their bank. declined transaction  Card Issuer Declined CVV
        #
        # The customer entered in an invalid security code or made a typo in their card information. Have the customer attempt the transaction again – if the decline persists
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2010
        def self.card_issuer_declined_cvv
          rand(2010.00..2010.99)
        end
        

        # Generate an amount for a Hard declined transaction  Voice Authorization Required
        #
        # The customer’s bank is requesting that the merchant (you) call to obtain a special authorization code in order to complete this transaction. This can result in a lengthy process – we recommend obtaining a new payment method instead. <a href="/help?issue=DeclinedTransaction">Contact us</a> for more details.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2011
        def self.voice_authorization_required
          rand(2011.00..2011.99)
        end
        

        # Generate an amount for a Hard declined transaction  Processor Declined – Possible Lost Card
        #
        # The card used has likely been reported as lost. The customer will need to contact their bank for more information.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2012
        def self.processor_declined_possible_lost_card
          rand(2012.00..2012.99)
        end
        

        # Generate an amount for a Hard declined transaction  Processor Declined – Possible Stolen Card
        #
        # The card used has likely been reported as stolen. The customer will need to contact their bank for more information.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2013
        def self.processor_declined_possible_stolen_card
          rand(2013.00..2013.99)
        end
        

        # Generate an amount for a Hard declined transaction  Processor Declined – Fraud Suspected
        #
        # The customer’s bank suspects fraud – they will need to contact their bank for more information.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2014
        def self.processor_declined_fraud_suspected
          rand(2014.00..2014.99)
        end
        

        # Generate an amount for a possibly due to an issue with the card itself. They will need to contact their bank or use a different payment method. declined transaction  Transaction Not Allowed
        #
        # The customer's bank is declining the transaction for unspecified reasons
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2015
        def self.transaction_not_allowed
          rand(2015.00..2015.99)
        end
        

        # Generate an amount for a Soft declined transaction  Duplicate Transaction
        #
        # The submitted transaction appears to be a duplicate of a previously submitted transaction and was declined to prevent charging the same card twice for the same service.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2016
        def self.duplicate_transaction
          rand(2016.00..2016.99)
        end
        

        # Generate an amount for a Hard declined transaction  Cardholder Stopped Billing
        #
        # The customer requested a cancellation of a single transaction – reach out to them for more information.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2017
        def self.cardholder_stopped_billing
          rand(2017.00..2017.99)
        end
        

        # Generate an amount for a Hard declined transaction  Cardholder Stopped All Billing
        #
        # The customer requested the cancellation of a recurring transaction or subscription – reach out to them for more information.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2018
        def self.cardholder_stopped_all_billing
          rand(2018.00..2018.99)
        end
        

        # Generate an amount for a typically because the card in question does not support this type of transaction – for example declined transaction  Invalid Transaction
        #
        # The customer’s bank declined the transaction
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2019
        def self.invalid_transaction
          rand(2019.00..2019.99)
        end
        

        # Generate an amount for a Hard declined transaction  Violation
        #
        # The customer will need to contact their bank for more information.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2020
        def self.violation
          rand(2020.00..2020.99)
        end
        

        # Generate an amount for a possibly due to a fraud concern. They will need to contact their bank or use a different payment method. declined transaction  Security Violation
        #
        # The customer's bank is declining the transaction
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2021
        def self.security_violation
          rand(2021.00..2021.99)
        end
        

        # Generate an amount for a Hard declined transaction  Declined – Updated Cardholder Available
        #
        # The submitted card has expired or been reported lost and a new card has been issued. Reach out to your customer to obtain updated card information.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2022
        def self.declined_updated_cardholder_available
          rand(2022.00..2022.99)
        end
        

        # Generate an amount for a 3D Secure or Level 2/Level 3 data. If you believe your merchant account should be set up to accept this type of transaction declined transaction  Processor Does Not Support This Feature
        #
        # Your account can't process transactions with the intended feature – for example
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2023
        def self.processor_does_not_support_this_feature
          rand(2023.00..2023.99)
        end
        

        # Generate an amount for a <a href="/help?issue=DeclinedTransaction">contact us</a> for assistance. declined transaction  Card Type Not Enabled
        #
        # Your account can't process the attempted card type. If you believe your merchant account should be set up to accept this type of card
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2024
        def self.card_type_not_enabled
          rand(2024.00..2024.99)
        end
        

        # Generate an amount for a this response could indicate a connectivity or setup issue. <a href="/help?issue=DeclinedTransaction">Contact us</a> for more information regarding this error message. declined transaction  Set Up Error – Merchant
        #
        # Depending on your region
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2025
        def self.set_up_error_merchant
          rand(2025.00..2025.99)
        end
        

        # Generate an amount for a typically because the card in question does not support this type of transaction. If this response persists across transactions for multiple customers declined transaction  Invalid Merchant ID
        #
        # The customer’s bank declined the transaction
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2026
        def self.invalid_merchant_id
          rand(2026.00..2026.99)
        end
        

        # Generate an amount for a Hard declined transaction  Set Up Error – Amount
        #
        # This rare decline code indicates an issue with processing the amount of the transaction. The customer will need to contact their bank for more details.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2027
        def self.set_up_error_amount
          rand(2027.00..2027.99)
        end
        

        # Generate an amount for a Hard declined transaction  Set Up Error – Hierarchy
        #
        # There is a setup issue with your account. <a href="/help?issue=DeclinedTransaction">Contact us</a> for more information.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2028
        def self.set_up_error_hierarchy
          rand(2028.00..2028.99)
        end
        

        # Generate an amount for a Hard declined transaction  Set Up Error – Card
        #
        # This response generally indicates that there is a problem with the submitted card. The customer will need to use a different payment method.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2029
        def self.set_up_error_card
          rand(2029.00..2029.99)
        end
        

        # Generate an amount for a Hard declined transaction  Set Up Error – Terminal
        #
        # There is a setup issue with your account. <a href="/help?issue=DeclinedTransaction">Contact us</a> for more information.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2030
        def self.set_up_error_terminal
          rand(2030.00..2030.99)
        end
        

        # Generate an amount for a Hard declined transaction  Encryption Error
        #
        # The cardholder’s bank does not support $0.00 card verifications. Enable the <a href="https://articles.braintreepayments.com/control-panel/vault/card-verification#retrying-all-failed-$0-verifications">Retry All Failed $0</a> option to resolve this error. <a href="/help?issue=DeclinedTransaction">Contact us</a> with questions.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2031
        def self.encryption_error
          rand(2031.00..2031.99)
        end
        

        # Generate an amount for a Hard declined transaction  Surcharge Not Permitted
        #
        # Surcharge amount not permitted on this card. The customer will need to use a different payment method.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2032
        def self.surcharge_not_permitted
          rand(2032.00..2032.99)
        end
        

        # Generate an amount for a Hard declined transaction  Inconsistent Data
        #
        # An error occurred when communicating with the processor. The customer will need to contact their bank for more details.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2033
        def self.inconsistent_data
          rand(2033.00..2033.99)
        end
        

        # Generate an amount for a Soft declined transaction  No Action Taken
        #
        # An error occurred and the intended transaction was not completed. Attempt the transaction again.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2034
        def self.no_action_taken
          rand(2034.00..2034.99)
        end
        

        # Generate an amount for a the customer will need to use a different payment method. declined transaction  Partial Approval For Amount In Group III Version
        #
        # The customer's bank approved the transaction for less than the requested amount. Have the customer attempt the transaction again – if the decline persists
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2035
        def self.partial_approval_for_amount_in_group_iii_version
          rand(2035.00..2035.99)
        end
        

        # Generate an amount for a Hard declined transaction  Authorization could not be found
        #
        # An error occurred when trying to process the authorization. This response could indicate an issue with the customer’s card or that the processor doesn't allow this action – <a href="/help?issue=DeclinedTransaction">contact us</a> for more information.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2036
        def self.authorization_could_not_be_found
          rand(2036.00..2036.99)
        end
        

        # Generate an amount for a <a href="/help?issue=DeclinedTransaction">contact us</a> for more information. declined transaction  Already Reversed
        #
        # The indicated authorization has already been reversed. If you believe this to be false
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2037
        def self.already_reversed
          rand(2037.00..2037.99)
        end
        

        # Generate an amount for a Soft declined transaction  Processor Declined
        #
        # The customer's bank is unwilling to accept the transaction. The reasons for this response can vary – customer will need to contact their bank for more details.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2038
        def self.processor_declined
          rand(2038.00..2038.99)
        end
        

        # Generate an amount for a they will need to contact their bank. declined transaction  Invalid Authorization Code
        #
        # The authorization code was not found or not provided. Have the customer attempt the transaction again – if the decline persists
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2039
        def self.invalid_authorization_code
          rand(2039.00..2039.99)
        end
        

        # Generate an amount for a <a href="/help?issue=DeclinedTransaction">contact us</a> for more information. declined transaction  Invalid Store
        #
        # There may be an issue with the configuration of your account. Have the customer attempt the transaction again – if the decline persists
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2040
        def self.invalid_store
          rand(2040.00..2040.99)
        end
        

        # Generate an amount for a Hard declined transaction  Declined – Call For Approval
        #
        # The card used for this transaction requires customer approval – they will need to contact their bank.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2041
        def self.declined_call_for_approval
          rand(2041.00..2041.99)
        end
        

        # Generate an amount for a <a href="/help?issue=DeclinedTransaction">contact us</a> for more information. declined transaction  Invalid Client ID
        #
        # There may be an issue with the configuration of your account. Have the customer attempt the transaction again – if the decline persists
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2042
        def self.invalid_client_id
          rand(2042.00..2042.99)
        end
        

        # Generate an amount for a The card-issuing bank will not allow this transaction. The customer will need to contact their bank for more information. declined transaction  Error – Do Not Retry
        #
        # Call Issuer
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2043
        def self.error_do_not_retry
          rand(2043.00..2043.99)
        end
        

        # Generate an amount for a they will need to contact their bank for more information. declined transaction  Declined – Call Issuer
        #
        # The card-issuing bank has declined this transaction. Have the customer attempt the transaction again – if the decline persists
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2044
        def self.declined_call_issuer
          rand(2044.00..2044.99)
        end
        

        # Generate an amount for a Hard declined transaction  Invalid Merchant Number
        #
        # There is a setup issue with your account. <a href="/help?issue=DeclinedTransaction">Contact us</a> for more information.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2045
        def self.invalid_merchant_number
          rand(2045.00..2045.99)
        end
        

        # Generate an amount for a the customer will need to contact their bank for more details regarding this generic decline; if this is a PayPal transaction declined transaction  Declined
        #
        # The customer's bank is unwilling to accept the transaction. For credit/debit card transactions
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2046
        def self.declined
          rand(2046.00..2046.99)
        end
        

        # Generate an amount for a you don’t have the physical card and can't complete this request – obtain a different payment method from the customer. declined transaction  Call Issuer. Pick Up Card
        #
        # The customer’s card has been reported as lost or stolen by the cardholder and the card-issuing bank has requested that merchants keep the card and call the number on the back to report it. As an online merchant
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2047
        def self.call_issuer_pick_up_card
          rand(2047.00..2047.99)
        end
        

        # Generate an amount for a is unreadable declined transaction  Invalid Amount
        #
        # The authorized amount is set to zero
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2048
        def self.invalid_amount
          rand(2048.00..2048.99)
        end
        

        # Generate an amount for a Hard declined transaction  Invalid SKU Number
        #
        # A non-numeric value was sent with the attempted transaction. Fix errors and resubmit with the transaction with the proper SKU Number.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2049
        def self.invalid_sku_number
          rand(2049.00..2049.99)
        end
        

        # Generate an amount for a Hard declined transaction  Invalid Credit Plan
        #
        # There may be an issue with the customer’s card or a temporary issue at the card-issuing bank. The customer will need to contact their bank for more information or use a different payment method.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2050
        def self.invalid_credit_plan
          rand(2050.00..2050.99)
        end
        

        # Generate an amount for a ask for a different card or payment method. declined transaction  Credit Card Number does not match method of payment
        #
        # There may be an issue with the customer’s credit card or a temporary issue at the card-issuing bank. Have the customer attempt the transaction again – if the decline persists
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2051
        def self.credit_card_number_does_not_match_method_of_payment
          rand(2051.00..2051.99)
        end
        

        # Generate an amount for a Hard declined transaction  Card reported as lost or stolen
        #
        # The card used was reported lost or stolen. The customer will need to contact their bank for more information or use a different payment method.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2053
        def self.card_reported_as_lost_or_stolen
          rand(2053.00..2053.99)
        end
        

        # Generate an amount for a Hard declined transaction  Reversal amount does not match authorization amount
        #
        # Either the refund amount is greater than the original transaction or the card-issuing bank does not allow <a href="/reference/request/transaction/refund/ruby#partial-refunds">partial refunds</a>. The customer will need to contact their bank for more information or use a different payment method.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2054
        def self.reversal_amount_does_not_match_authorization_amount
          rand(2054.00..2054.99)
        end
        

        # Generate an amount for a Hard declined transaction  Invalid Transaction Division Number
        #
        # <a href="/help?issue=DeclinedTransaction">Contact us</a> for more information regarding this error message.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2055
        def self.invalid_transaction_division_number
          rand(2055.00..2055.99)
        end
        

        # Generate an amount for a Hard declined transaction  Transaction amount exceeds the transaction division limit
        #
        # <a href="/help?issue=DeclinedTransaction">Contact us</a> for more information regarding this error message.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2056
        def self.transaction_amount_exceeds_the_transaction_division_limit
          rand(2056.00..2056.99)
        end
        

        # Generate an amount for a Soft declined transaction  Issuer or Cardholder has put a restriction on the card
        #
        # The customer will need to contact their issuing bank for more information.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2057
        def self.issuer_or_cardholder_has_put_a_restriction_on_the_card
          rand(2057.00..2057.99)
        end
        

        # Generate an amount for a Hard declined transaction  Merchant not Mastercard SecureCode enabled
        #
        # The attempted card can't be processed without enabling <a href="/guides/3d-secure/overview">3D Secure</a> for your account. <a href="/help?issue=DeclinedTransaction">Contact us</a> for more information regarding this feature or contact the customer for a different payment method.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2058
        def self.merchant_not_mastercard_securecode_enabled
          rand(2058.00..2058.99)
        end
        

        # Generate an amount for a Address Verification and Card Security Code Failed declined transaction  Address Verification Failed
        #
        # 0
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2059
        def self.address_verification_failed
          rand(2059.00..2059.99)
        end
        

        # Generate an amount for a ask for a different card or payment method. declined transaction  Invalid Transaction Data
        #
        # There may be an issue with the customer’s card or a temporary issue at the card-issuing bank. Have the customer attempt the transaction again – if the decline persists
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2061
        def self.invalid_transaction_data
          rand(2061.00..2061.99)
        end
        

        # Generate an amount for a ask for a different card or payment method. declined transaction  Invalid Tax Amount
        #
        # There may be an issue with the customer’s card or a temporary issue at the card-issuing bank. Have the customer attempt the transaction again – if the decline persists
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2062
        def self.invalid_tax_amount
          rand(2062.00..2062.99)
        end
        

        # Generate an amount for a Invalid Currency Code declined transaction  PayPal Business Account preference resulted in the transaction failing
        #
        # 4
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2063
        def self.paypal_business_account_preference_resulted_in_the_transaction_failing
          rand(2063.00..2063.99)
        end
        

        # Generate an amount for a Hard declined transaction  Refund Time Limit Exceeded
        #
        # PayPal requires that refunds are issued within 180 days of the sale. This refund can't be successfully processed.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2065
        def self.refund_time_limit_exceeded
          rand(2065.00..2065.99)
        end
        

        # Generate an amount for a you can attempt the transaction again. declined transaction  PayPal Business Account Restricted
        #
        # <a href="https://articles.braintreepayments.com/guides/payment-methods/paypal/setup-guide#contacting-paypal-support">Contact PayPal’s Support team</a> to resolve this issue with your account. Then
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2066
        def self.paypal_business_account_restricted
          rand(2066.00..2066.99)
        end
        

        # Generate an amount for a Hard declined transaction  Authorization Expired
        #
        # The PayPal authorization is no longer valid.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2067
        def self.authorization_expired
          rand(2067.00..2067.99)
        end
        

        # Generate an amount for a you can attempt to process the transaction again. declined transaction  PayPal Business Account Locked or Closed
        #
        # You'll need to <a href="https://articles.braintreepayments.com/guides/payment-methods/paypal/setup-guide#contacting-paypal-support">contact PayPal’s Support team</a> to resolve an issue with your account. Once resolved
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2068
        def self.paypal_business_account_locked_or_closed
          rand(2068.00..2068.99)
        end
        

        # Generate an amount for a Hard declined transaction  PayPal Blocking Duplicate Order IDs
        #
        # The submitted PayPal transaction appears to be a duplicate of a previously submitted transaction. This decline code indicates an attempt to prevent charging the same PayPal account twice for the same service.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2069
        def self.paypal_blocking_duplicate_order_ids
          rand(2069.00..2069.99)
        end
        

        # Generate an amount for a Hard declined transaction  PayPal Buyer Revoked Pre-Approved Payment Authorization
        #
        # The customer revoked authorization for this payment method. Reach out to the customer for more information or a different payment method.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2070
        def self.paypal_buyer_revoked_pre_approved_payment_authorization
          rand(2070.00..2070.99)
        end
        

        # Generate an amount for a Hard declined transaction  PayPal Payee Account Invalid Or Does Not Have a Confirmed Email
        #
        # Customer has not finalized setup of their PayPal account. Reach out to the customer for more information or a different payment method.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2071
        def self.paypal_payee_account_invalid_or_does_not_have_a_confirmed_email
          rand(2071.00..2071.99)
        end
        

        # Generate an amount for a Hard declined transaction  PayPal Payee Email Incorrectly Formatted
        #
        # Customer made a typo or is attempting to use an invalid PayPal account.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2072
        def self.paypal_payee_email_incorrectly_formatted
          rand(2072.00..2072.99)
        end
        

        # Generate an amount for a Hard declined transaction  PayPal Validation Error
        #
        # PayPal can't validate this transaction. <a href="/help?issue=DeclinedTransaction">Contact us</a> for more details.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2073
        def self.paypal_validation_error
          rand(2073.00..2073.99)
        end
        

        # Generate an amount for a The customer’s payment method associated with their PayPal account was declined. Reach out to the customer for more information or a different payment method. declined transaction  Funding Instrument In The PayPal Account Was Declined By The Processor Or Bank
        #
        # Or It Can't Be Used For This Payment
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2074
        def self.funding_instrument_in_the_paypal_account_was_declined_by_the_processor_or_bank
          rand(2074.00..2074.99)
        end
        

        # Generate an amount for a Hard declined transaction  Payer Account Is Locked Or Closed
        #
        # The customer’s PayPal account can't be used for transactions at this time. The customer will need to contact PayPal for more information or use a different payment method.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2075
        def self.payer_account_is_locked_or_closed
          rand(2075.00..2075.99)
        end
        

        # Generate an amount for a Hard declined transaction  Payer Cannot Pay For This Transaction With PayPal
        #
        # The customer should contact PayPal for more information or use a different payment method. You may also receive this response if you create transactions using the email address registered with your PayPal Business Account.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2076
        def self.payer_cannot_pay_for_this_transaction_with_paypal
          rand(2076.00..2076.99)
        end
        

        # Generate an amount for a Hard declined transaction  Transaction Refused Due To PayPal Risk Model
        #
        # PayPal has declined this transaction due to risk limitations. You'll need to <a href="https://articles.braintreepayments.com/guides/payment-methods/paypal/setup-guide#contacting-paypal-support">contact PayPal’s Support team</a> to resolve this issue.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2077
        def self.transaction_refused_due_to_paypal_risk_model
          rand(2077.00..2077.99)
        end
        

        # Generate an amount for a you can attempt to process the transaction again. declined transaction  PayPal Merchant Account Configuration Error
        #
        # You'll need to <a href="/help?issue=DeclinedTransaction">contact us</a> to resolve an issue with your account. Once resolved
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2079
        def self.paypal_merchant_account_configuration_error
          rand(2079.00..2079.99)
        end
        

        # Generate an amount for a have the customer reach out to PayPal for more information. declined transaction  PayPal pending payments are not supported
        #
        # Braintree received an unsupported Pending Verification response from PayPal. Contact <a href="/help?issue=DeclinedTransaction">Braintree’s Support team</a> to resolve a potential issue with your account settings. If there is no issue with your account
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2081
        def self.paypal_pending_payments_are_not_supported
          rand(2081.00..2081.99)
        end
        

        # Generate an amount for a Hard declined transaction  PayPal Domestic Transaction Required
        #
        # This transaction requires the customer to be a resident of the same country as the merchant. Reach out to the customer for a different payment method.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2082
        def self.paypal_domestic_transaction_required
          rand(2082.00..2082.99)
        end
        

        # Generate an amount for a Hard declined transaction  PayPal Phone Number Required
        #
        # This transaction requires the payer to provide a valid phone number. The customer should contact PayPal for more information or use a different payment method.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2083
        def self.paypal_phone_number_required
          rand(2083.00..2083.99)
        end
        

        # Generate an amount for a including submitting their phone number and all required tax information. declined transaction  PayPal Tax Info Required
        #
        # The customer must complete their PayPal account information
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2084
        def self.paypal_tax_info_required
          rand(2084.00..2084.99)
        end
        

        # Generate an amount for a Hard declined transaction  PayPal Payee Blocked Transaction
        #
        # Fraud settings on your PayPal business account are blocking payments from this customer. These can be adjusted in the <strong>Block Payments</strong> section of your PayPal business account.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2085
        def self.paypal_payee_blocked_transaction
          rand(2085.00..2085.99)
        end
        

        # Generate an amount for a Hard declined transaction  PayPal Transaction Limit Exceeded
        #
        # The settings on the customer's account do not allow a transaction amount this large. They will need to contact PayPal to resolve this issue.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2086
        def self.paypal_transaction_limit_exceeded
          rand(2086.00..2086.99)
        end
        

        # Generate an amount for a you can attempt to process the transaction again. declined transaction  PayPal reference transactions not enabled for your account
        #
        # PayPal API permissions are not set up to allow reference transactions. You'll need to <a href="https://articles.braintreepayments.com/guides/payment-methods/paypal/setup-guide#contacting-paypal-support">contact PayPal’s Support team</a> to resolve an issue with your account. Once resolved
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2087
        def self.paypal_reference_transactions_not_enabled_for_your_account
          rand(2087.00..2087.99)
        end
        

        # Generate an amount for a PayPal payee email permission denied for this request declined transaction  Currency not enabled for your PayPal seller account
        #
        # 9
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2088
        def self.currency_not_enabled_for_your_paypal_seller_account
          rand(2088.00..2088.99)
        end
        

        # Generate an amount for a Hard declined transaction  PayPal account not configured to refund more than settled amount
        #
        # Your PayPal account is not set up to refund amounts higher than the original transaction amount. <a href="https://articles.braintreepayments.com/guides/payment-methods/paypal/setup-guide#contacting-paypal-support">Contact PayPal's Support team</a> for information on how to enable this.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2090
        def self.paypal_account_not_configured_to_refund_more_than_settled_amount
          rand(2090.00..2090.99)
        end
        

        # Generate an amount for a Hard declined transaction  Currency of this transaction must match currency of your PayPal account
        #
        # Your PayPal account can only process transactions in the currency of your home country. <a href="https://articles.braintreepayments.com/guides/payment-methods/paypal/setup-guide#contacting-paypal-support">Contact PayPal's Support team</a> for more information.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2091
        def self.currency_of_this_transaction_must_match_currency_of_your_paypal_account
          rand(2091.00..2091.99)
        end
        

        # Generate an amount for a Soft declined transaction  No Data Found - Try Another Verification Method
        #
        # The processor is unable to provide a definitive answer about the customer's bank account. Please try a different US bank account verification method.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2092
        def self.no_data_found_try_another_verification_method
          rand(2092.00..2092.99)
        end
        

        # Generate an amount for a Hard declined transaction  PayPal payment method is invalid
        #
        # The PayPal payment method has either expired or been canceled.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2093
        def self.paypal_payment_method_is_invalid
          rand(2093.00..2093.99)
        end
        

        # Generate an amount for a Hard declined transaction  PayPal payment has already been completed
        #
        # Your integration is likely making PayPal calls out of sequence. Check the error response for more details.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2094
        def self.paypal_payment_has_already_been_completed
          rand(2094.00..2094.99)
        end
        

        # Generate an amount for a all subsequent refunds must also be partial refunds for the remaining amount or less. Full refunds are not allowed after a PayPal transaction has been partially refunded. declined transaction  PayPal refund is not allowed after partial refund
        #
        # Once a PayPal transaction is partially refunded
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2095
        def self.paypal_refund_is_not_allowed_after_partial_refund
          rand(2095.00..2095.99)
        end
        

        # Generate an amount for a Hard declined transaction  PayPal buyer account can't be the same as the seller account
        #
        # PayPal buyer account can't be the same as the seller account.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2096
        def self.paypal_buyer_account_cant_be_the_same_as_the_seller_account
          rand(2096.00..2096.99)
        end
        

        # Generate an amount for a Hard declined transaction  PayPal authorization amount limit exceeded
        #
        # PayPal authorization amount is greater than the allowed limit on the order.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2097
        def self.paypal_authorization_amount_limit_exceeded
          rand(2097.00..2097.99)
        end
        

        # Generate an amount for a Hard declined transaction  PayPal authorization count limit exceeded
        #
        # The number of PayPal authorizations is greater than the allowed number on the order.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2098
        def self.paypal_authorization_count_limit_exceeded
          rand(2098.00..2098.99)
        end
        

        # Generate an amount for a then attempt the authorization again. declined transaction  Cardholder Authentication Required
        #
        # The customer's bank declined the transaction because a 3D Secure authentication was not performed during checkout. Have the customer authenticate using 3D Secure
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2099
        def self.cardholder_authentication_required
          rand(2099.00..2099.99)
        end
        

        # Generate an amount for a you can attempt to process the transaction again. declined transaction  PayPal channel initiated billing not enabled for your account
        #
        # Your PayPal permissions are not set up to allow channel initiated billing transactions. <a href="https://articles.braintreepayments.com/guides/payment-methods/paypal/setup-guide#contacting-paypal-support">Contact PayPal's Support team</a> for information on how to enable this. Once resolved
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2100
        def self.paypal_channel_initiated_billing_not_enabled_for_your_account
          rand(2100.00..2100.99)
        end
        

        # Generate an amount for a Soft declined transaction  Additional authorization required
        #
        # This transaction requires additional customer credentials for authorization. The customer should insert their chip.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2101
        def self.additional_authorization_required
          rand(2101.00..2101.99)
        end
        

        # Generate an amount for a Soft declined transaction  Incorrect PIN
        #
        # The entered PIN was incorrect.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2102
        def self.incorrect_pin
          rand(2102.00..2102.99)
        end
        

        # Generate an amount for a Soft declined transaction  PIN try exceeded
        #
        # The allowable number of PIN tries has been exceeded.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2103
        def self.pin_try_exceeded
          rand(2103.00..2103.99)
        end
        

        # Generate an amount for a Soft declined transaction  Offline Issuer Declined
        #
        # The transaction was declined offline by the issuer. The customer will need to contact their bank for more information.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2104
        def self.offline_issuer_declined
          rand(2104.00..2104.99)
        end
        

        # Generate an amount for a Soft declined transaction  Processor Declined
        #
        # The customer's bank is unwilling to accept the transaction. The customer will need to contact their bank for more details regarding this generic decline.
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-2105-2999
        def self.processor_declined
          rand(2105.00-2999.99)
        end
        

        # Generate an amount for a not necessarily a problem with the payment method. Have the customer attempt the transaction again – if the decline persists declined transaction  Processor Network Unavailable – Try Again
        #
        # This response could indicate a problem with the back-end processing network
        # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-3000
        def self.processor_network_unavailable_try_again
          rand(3000.00..3000.99)
        end

        # Generate an amount for an authorized and declined transaction
        #
        # Settlement Declined on certain transaction types with a processor response equal to the amount; Settled on all others
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#amount-400100-400199
        def self.declined
          rand(4001.00..4001.99)
        end

        # Generate an amount for an authorized and pending transaction
        #
        # Settlement Pending on PayPal transactions with a processor response equal to the amount; Settled on all others
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#amount-400200-400299
        def self.pending
          rand(4002.00..4002.99)
        end

        
        # Settlement Declined
        #
        # The processor declined to settle the sale or refund request.
        # https://developers.braintreepayments.com/reference/general/processor-responses/settlement-responses#code-4001
        def self.settlement_declined
            rand(4001.00..4001.99)
        end
        
        # Already Captured
        #
        # The transaction has already been fully captured.
        # https://developers.braintreepayments.com/reference/general/processor-responses/settlement-responses#code-4003
        def self.already_captured
            rand(4003.00..4003.99)
        end
        
        # Already Refunded
        #
        # The transaction has already been fully refunded.
        # https://developers.braintreepayments.com/reference/general/processor-responses/settlement-responses#code-4004
        def self.already_refunded
            rand(4004.00..4004.99)
        end
        
        # PayPal Risk Rejected
        #
        # The sale request was rejected by PayPal risk.
        # https://developers.braintreepayments.com/reference/general/processor-responses/settlement-responses#code-4005
        def self.paypal_risk_rejected
            rand(4005.00..4005.99)
        end
        
        # Capture Amount Exceeded Allowable Limit
        #
        # The specified capture amount exceeded the amount allowed by the processor.
        # https://developers.braintreepayments.com/reference/general/processor-responses/settlement-responses#code-4006
        def self.capture_amount_exceeded_allowable_limit
            rand(4006.00..4006.99)
        end
        
        # PayPal Pending Payments Not Supported
        #
        # PayPal returned a pending sale or refund response which is disallowed by Braintree. This failure is likely due to a misconfiguration in your PayPal account. Further details may be found in the transaction details.
        # https://developers.braintreepayments.com/reference/general/processor-responses/settlement-responses#code-4018
        def self.paypal_pending_payments_not_supported
            rand(4018.00..4018.99)
        end
        
        # PayPal Refund Transaction with an Open Case Not Allowed
        #
        # PayPal declined to settle the refund request as there is an open dispute against the transaction. If you have enabled PayPal disputes within Braintree, you may resolve the dispute within the Braintree disputes dashboard. Otherwise, you may do so via your PayPal account's Resolution Center.
        # https://developers.braintreepayments.com/reference/general/processor-responses/settlement-responses#code-4019
        def self.paypal_refund_transaction_with_an_open_case_not_allowed
          rand(4019.00..4019.99)
        end
        
        # PayPal Refund Attempt Limit Reached
        #
        # PayPal's maximum number of refund attempts for this transaction has been exceeded.
        # https://developers.braintreepayments.com/reference/general/processor-responses/settlement-responses#code-4020
        def self.paypal_refund_attempt_limit_reached
            rand(4020.00..4020.99)
        end
        
        # PayPal Refund Transaction Not Allowed
        #
        # PayPal does not allow you to refund this type of transaction.
        # https://developers.braintreepayments.com/reference/general/processor-responses/settlement-responses#code-4021
        def self.paypal_refund_transaction_not_allowed
            rand(4021.00..4021.99)
        end
        
        # PayPal Refund Invalid Partial Amount
        #
        # The partial refund amount is not valid.
        # https://developers.braintreepayments.com/reference/general/processor-responses/settlement-responses#code-4022
        def self.paypal_refund_invalid_partial_amount
            rand(4022.00..4022.99)
        end
        
        # PayPal Refund Merchant Account Missing ACH
        #
        # Your PayPal account does not have an associated verified bank account.
        # https://developers.braintreepayments.com/reference/general/processor-responses/settlement-responses#code-4023
        def self.paypal_refund_merchant_account_missing_ach
            rand(4023.00..4023.99)
        end

        # Generate an amount for a Gateway Rejected transaction
        #
        # Gateway Rejected with a reason of Application Incomplete
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#amount-500100
        def self.gateway_rejected
          5001.00
        end

        # Generate an amount for a PayPal Rejected transaction
        #
        # Processor Declined on PayPal transactions in the Mocked PayPal flow with a 2038 processor response. Authorized on all others
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#amount-500101
        def self.paypal_rejected
          5001.01
        end

        # Generate an amount for a n Processor Unavailable transaction
        #
        # Processor Unavailable on certain transaction types with a processor response of 3000; Settled on all others
        # more info: https://developers.braintreepayments.com/reference/general/testing/ruby#amount-500102
        def self.processor_unavailable
          5001.02
        end
      end
    end
  end
end
