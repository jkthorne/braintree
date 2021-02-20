class Braintree::Queries::TransactionQuery < BTQ::Query
  private getter id : String
  private getter source : String # Extract into constant or enum

  def initialize(@id, @source = "local")
  end

  def exec
    if @source == "local"
      transaction = BT::Models::Transaction.load(id)

      if transaction
        yield self, transaction
        return nil
      end
    end

    response = Braintree.http.get("/merchants/#{BT.config.merchant}/transactions/#{id}")
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
