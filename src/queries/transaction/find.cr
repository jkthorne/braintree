class Braintree::Transaction::Find < Braintree::Query
  getter response : HTTP::Client::Response?
  getter id : String

  def initialize(@id, @source = "local")
    @resource = HTTP::Request.new(
      method: "GET",
      resource: "/merchants/#{BT.config.merchant}/transactions/#{id}"
    )
  end

  def exec
    if @source == "local"
      transaction = BT::Models::Transaction.load(id)

      if transaction
        yield self, transaction
        return nil
      end
    end

    response = Braintree.http.exec(@resource)
    @response = response

    Log.debug { "Transaction(#{id}) #{response.success? ? "Succesfully" : "Failed"} to fetch from remote" }

    if xml_node = XML.parse(response.body).xpath_node("./transaction")
      transaction = BT::Models::Transaction.new(xml_node)
      transaction.store
      yield self, transaction
    else
      yield self, nil
    end
  end
end
