class Braintree::Operations::CreateTransaction < BTO::Operation
  private getter amount : String
  private getter credit_card : NamedTuple(number: String, expiration_date: String)
  private getter type : String

  def initialize(@amount, @credit_card, @type = "sale")
  end

  def self.exec(*args, **kargs)
    new(*args, **kargs).exec do |op, tx|
      yield op, tx
    end
  end

  def exec
    response = Braintree.http.post(
      path: "/merchants/#{BT.settings.merchant}/transactions",
      body: Braintree.xml { |t|
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

    yield self, response.success? ? JSON.parse(response.body) : nil
  end
end
