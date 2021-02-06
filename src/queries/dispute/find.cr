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

    xml = XML.parse(response.body).xpath_node("dispute")
    if xml
      dispute = BT::Models::Dispute.new(xml)
      dispute.store
    end
    yield self, dispute ? dispute : nil
  end
end
