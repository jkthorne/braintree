class Braintree::Queries::Dispute::Find < BTQ::Query
  private getter id : String

  def initialize(@id)
  end

  def exec
    response = Braintree.http.get("/merchants/#{BT.settings.merchant}/disputes/#{id}")

    yield response, response.success? ? BT::Models::Dispute.new(XML.parse(response.body)) : nil
  end
end
