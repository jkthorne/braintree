class Braintree::Dispute::AddTextEvidence < Braintree::Operation
  def initialize(dispute_id, content)
    @request = HTTP::Request.new(
      method: "POST",
      resource: "/merchants/#{BT.config.merchant}/disputes/#{dispute_id}/evidence",
      body: Braintree.xml { |t|
        t.evidence {
          t.comments content
        }
      }
    )
  end

  def exec
    response = Braintree.http.exec(request)
    @response = response

    yield self, response.success? ? Evidence.new(XML.parse(response.body)) : nil
  end
end
