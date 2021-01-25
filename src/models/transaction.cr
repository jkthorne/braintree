module Braintree
  class Transaction
    getter amount : String
    getter credit_card : NamedTuple(number: String, expiration: String)

    def initialize(@amount, @credit_card : NamedTuple(number: String, expiration: String))
    end

    def initialize(hash : Hash(String,String))
      @amount = hash["amount"]
      @credit_card = {
        number: hash["card_number"],
        expiration: hash["card_expiration"]
      }
    end

    def to_params
      { amount: @amount, credit_card: @credit_card }
    end

    def self.create(*args, **kargs)
      CreateTransaction.exec(*args, **kargs) do |op, tx|
        yield op, tx
      end
    end
  end
end
