class Braintree::Queries::Transaction::Find < BTQ::Query
  private getter id : String

  def initialize(@id)
  end

  def exec
    response = Braintree.http.get(
      path: "/merchants/#{BT.settings.merchant}/transactions/#{id}"
    )

    yield response, response.success? ? BT::Models::Transaction.new(XML.parse(response.body)) : nil
  end
end
