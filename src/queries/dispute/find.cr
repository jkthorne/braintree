class Braintree::Queries::Dispute::Find < BTQ::Query
  private getter id : String
  private getter source : String # Extract into constant or enum

  def initialize(@id, @source = "local")
  end

  def exec
    if @source == "local"
      dispute = BT::Models::Dispute.load(id)

      if dispute
        yield self, dispute
        return nil
      end
    end

    response = Braintree.http.get("/merchants/#{BT.settings.merchant}/disputes/#{id}")
    Log.debug { "Dispute(#{id}) #{response.success? ? "Succesfully" : "Failed"} to fetch from remote" }

    dispute = BT::Models::Dispute.new(XML.parse(response.body))
    dispute.store
    yield self, response.success? ? dispute : nil
  end
end
