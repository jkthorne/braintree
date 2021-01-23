module Braintree
  class Transaction
    getter amount : String
    getter credit_card : NamedTuple(number: String, expiration_date: String)

    def initialize(@amount, @credit_card : NamedTuple(number: String, expiration_date: String))
    end

    def self.create(*args, **kargs)
      CreateTransaction.exec(*args, **kargs) do |op, tx|
        yield op, tx
      end
    end

    # Generates a valid set of params for a transaction
    def self.factory_params(amount : String?, number : String?, expiration_date : Time?)
      amount          ||= "#{rand(12..10_000)}.12"
      number          ||= Braintree::Test::CreditCardNumbers::Disputes::CHARGEBACK
      expiration_date ||= Time.utc.shift(months: rand(3..36))
      {
        amount: amount,
        credit_card: {
          number: number,
          expiration_date: "%02d/%s" % [expiration_date.month, expiration_date.year],
        }
      }
    end

    def self.sandbox
      Sandbox
    end
  end
end
