class Braintree::Operations::CreateTransaction < BTO::Operation
  getter amount : String
  getter card_number : String
  getter card_expiration : String
  getter type : String
  getter response : HTTP::Client::Response?

  def initialize(@amount, @card_number, @card_expiration, @type = "sale")
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
            t.number card_number
            t.expiration_date card_expiration
          }
          t.type type
        }
      }
    )

    @response = response # assign operation access later
    # # TODO: deserialize to objects
    yield self, response.success? ? BT::Transaction.new(XML.parse(response.body)) : nil
  end
end
