class Braintree::Transaction::Create < Braintree::Operation
  getter amount : String
  getter card_number : String
  getter card_expiration : String
  getter type : String
  getter response : HTTP::Client::Response?

  # TODO: use transaction object
  def initialize(@amount, @card_number, @card_expiration, @type = "sale")
    @request = HTTP::Request.new(
      method: "POST",
      resource: "/merchants/#{BT.config.merchant}/transactions",
      body: BT.xml { |t|
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
  end

  def exec
    response = BT.http.exec(request)
    @response = response

    xml = XML.parse(response.body).xpath_node("./transaction")
    yield self, xml ? BT::Models::Transaction.new(xml) : nil
  end
end
