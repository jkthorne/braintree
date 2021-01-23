class Braintree::Queries::Dispute::Find < BTQ::Query
  private getter id : String

  def initialize(@id)
  end

  def exec
    response = Braintree.http.get(
      path: "/merchants/#{BT.settings.merchant}/disputes/#{id}"
    )

    yield response, response.success? ? JSON.parse(response.body) : nil
  end
end