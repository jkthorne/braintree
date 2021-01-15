module Braintree
  class CreateTransaction
    getter amount : String
    getter credit_card : NamedTuple(number: String, expiration_date: String)
    getter type : String

    def initialize(@amount, @credit_card, @type = "sale")
    end

    def self.exec(*args, **kargs)
      new(*args, **kargs).exec do |op, tx|
        yield op, tx
      end
    end

    def exec
      response = Braintree.http(
        path: "/merchants/#{BT.settings.merchant}/transactions",
        body: Braintree.transaction_xml { |t|
          t.transaction {
            t.amount amount
            t.credit_card {
              t.number credit_card[:number]
              t.expiration_date credit_card[:expiration_date]
            }
            t.type type
          }
        }
      )

      yield response, response.success? ? JSON.parse(response.body) : nil
    end
  end
end
