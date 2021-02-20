class Braintree::Operations::Dispute::AddFileEvidence < BTO::Operation
  getter dispute_id : String
  getter document_id : String
  getter category : String?

  def initialize(@dispute_id, @document_id, @category = nil)
  end

  def self.exec(*args, **kargs)
    new(*args, **kargs).exec do |op, tx|
      yield op, tx
    end
  end

  def exec
    request = HTTP::Request.new(
      method: "POST",
      resource: "/merchants/#{BT.config.merchant}/disputes/#{dispute_id}/evidence",
      body: Braintree.xml { |t|
        t.evidence {
          t.document_upload_id document_id
          t.category category.not_nil! if category
        }
      }
    )

    response = Braintree.http.exec(request)
    @response = response
    yield self, response.success? ? Evidence.new(XML.parse(response.body)) : nil
  end
end
