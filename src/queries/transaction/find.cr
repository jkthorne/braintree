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

    response = Braintree.http.get("/merchants/#{BT.settings.merchant}/transactions/#{id}")
    Log.debug { "Transaction(#{id}) #{response.success? ? "Succesfully" : "Failed"} to fetch from remote" }

    transaction = BT::Models::Transaction.new(XML.parse(response.body))
    transaction.store
    yield self, response.success? ? transaction : nil
  end
end
