class Braintree::Transaction::Sale < Braintree::Operation
  def initialize(transaction)
    @request = HTTP::Request.new(
      method: "PUT",
      resource: "/merchants/#{BT.config.merchant}/disputes/#{dispute_id}/accept",
      body: transaction.to_xml
    )
  end
end
