class Braintree::Dispute::AddFileEvidence < Braintree::Operation
  def initialize(dispute_id, document_id, category = nil)
    @request = HTTP::Request.new(
      method: "POST",
      resource: "/merchants/#{BT.config.merchant}/disputes/#{dispute_id}/evidence",
      body: Braintree.xml { |t|
        t.evidence {
          t.document_upload_id document_id
          t.category category.not_nil! if category
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
