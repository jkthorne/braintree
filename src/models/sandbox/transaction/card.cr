module Braintree
  class Transaction
    module Sandbox
      module Card
        AMERICAN_EXPRESS_1                  = "378282246310005"
        AMERICAN_EXPRESS_2                  = "371449635398431"
        DINERS_CLUB                         = "36259600000004"
        DISCOVER                            = "6011000991300009"
        JCB                                 = "3530111333300000"
        MAESTRO                             = "6304000000000000"
        MASTERCARD_1                        = "5555555555554444"
        MASTERCARD_2                        = "2223000048400011"
        VISA_1                              = "4111111111111111"
        VISA_2                              = "4005519200000004"
        VISA_3                              = "4009348888881881"
        VISA_4                              = "4012000033330026"
        VISA_5                              = "4012000077777777"
        VISA_6                              = "4012888888881881"
        VISA_7                              = "4217651111111119"
        VISA_8                              = "4500600000000061"
        VISA_PROCESSOR_DECLINED             = "4000111111111115"
        MASTERCARD_PROCESSOR_DECLINED       = "5105105105105100"
        AMERICAN_EXPRESS_PROCESSOR_DECLINED = "378734493671000"
        DISCOVER_PROCESSOR_DECLINED         = "6011000990139424"
        DINERS_CLUB_PROCESSOR_DECLINED      = "38520000009814"
        JCB_FAILED                          = "3566002020360505"
        PREPAID                             = "4500600000000061"
        COMMERCIAL                          = "4009040000000009"
        DURBIN_REGULATED                    = "4005519200000004"
        HEALTHCARE                          = "4012000033330026"
        DEBIT                               = "4012000033330125"
        PAYROLL                             = "4012000033330224"
        NO_VALUES                           = "4012000033330422"
        UNKNOWN_VALUES                      = "4012000033330323"
        VISA_USA                            = "4012000033330620"
        VISA_CAN                            = "4012000033330729"
        VISA_IRL                            = "4023490000000008"
        VISA_GBR                            = "4444333322221111"
        MASTERCARD_GBR                      = "5555444433331111"
        AMEX_GBR                            = "374512431123241"
        AMEX_IRL                            = "375529658790105"
        MASTERCARD_IRL                      = "5101108206957373"
        VISA_NETWORK_ONLY                   = "4012000033330521"

        AMERICAN_EXPRESS = StaticArray[AMERICAN_EXPRESS_1, AMERICAN_EXPRESS_2]
        MASTERCARD       = StaticArray[MASTERCARD_1, MASTERCARD_2]
        VISA             = StaticArray[VISA_1, VISA_1, VISA_2, VISA_3, VISA_4, VISA_5, VISA_6, VISA_7]
        ALL              = StaticArray[
          AMERICAN_EXPRESS_1, AMERICAN_EXPRESS_2, DINERS_CLUB, DISCOVER, JCB, MAESTRO, MASTERCARD_1,
          MASTERCARD_2, VISA_1, VISA_2, VISA_3, VISA_4, VISA_5, VISA_6, VISA_7, VISA_8,
          VISA_PROCESSOR_DECLINED, MASTERCARD_PROCESSOR_DECLINED, AMERICAN_EXPRESS_PROCESSOR_DECLINED,
          DISCOVER_PROCESSOR_DECLINED, DINERS_CLUB_PROCESSOR_DECLINED, JCB_FAILED,
          PREPAID, COMMERCIAL, DURBIN_REGULATED, HEALTHCARE, DEBIT, PAYROLL, NO_VALUES, UNKNOWN_VALUES,
          VISA_USA, VISA_CAN, VISA_IRL, VISA_GBR, MASTERCARD_GBR, AMEX_GBR, AMEX_IRL, MASTERCARD_IRL, VISA_NETWORK_ONLY,
        ]
        VALID = StaticArray[
          AMERICAN_EXPRESS_1, AMERICAN_EXPRESS_2, DINERS_CLUB, DISCOVER, JCB, MAESTRO, MASTERCARD_1,
          MASTERCARD_2, VISA_1, VISA_2, VISA_3, VISA_4, VISA_5, VISA_6, VISA_7, VISA_8,
        ]
        UNSUCCESSFUL_VERIFICATION = StaticArray[
          VISA_PROCESSOR_DECLINED, MASTERCARD_PROCESSOR_DECLINED, AMERICAN_EXPRESS_PROCESSOR_DECLINED,
          DISCOVER_PROCESSOR_DECLINED, DINERS_CLUB_PROCESSOR_DECLINED, JCB_FAILED,
        ]
        TYPE_INDICATORS = StaticArray[
          PREPAID, COMMERCIAL, DURBIN_REGULATED, HEALTHCARE, DEBIT, PAYROLL, NO_VALUES, UNKNOWN_VALUES,
        ]
        COUNTRY_TYPE = StaticArray[
          VISA_USA, VISA_CAN, VISA_IRL, VISA_GBR, MASTERCARD_GBR, AMEX_GBR, AMEX_IRL, MASTERCARD_IRL, VISA_NETWORK_ONLY,
        ]

        def self.valid
          ALL.sample
        end

        def self.american_express
          AMERICAN_EXPRESS.sample
        end

        def self.dinners_club
          DINERS_CLUB
        end

        def self.discover
          DISCOVER
        end

        def self.jcb
          JCB
        end

        def self.maestro
          MAESTRO
        end

        def self.mastercard
          MASTERCARD.sample
        end

        def self.visa
          VISA.sample
        end

        def self.valid
          VALID.sample
        end

        def self.unsuccessful_verification
          UNSUCCESSFUL_VERIFICATION.sample
        end

        def self.type_indicators
          TYPE_INDICATORS.sample
        end

        def self.country_type
          COUNTRY_TYPE.sample
        end

        # Expiration
        def self.valid_expiration
          expiration_date = Time.utc.shift(months: rand(3..36))
          "%02d/%s" % [expiration_date.month, expiration_date.year]
        end
      end
    end
  end
end
