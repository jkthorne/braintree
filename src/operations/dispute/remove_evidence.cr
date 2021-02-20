class Braintree::Operations::Dispute::RemoveEvidence < BTO::Operation
  getter dispute_id : String
  getter evidence_id : String

  def initialize(@dispute_id, @evidence_id)
  end

  def self.exec(*args, **kargs)
    new(*args, **kargs).exec do |op, tx|
      yield op, tx
    end
  end

  def exec
    request = HTTP::Request.new(
      method: "DELETE",
      resource: "/merchants/#{BT.config.merchant}/disputes/#{dispute_id}/evidence/#{evidence_id}"
    )

    response = Braintree.http.exec(request)
    @response = response
    yield self, response.success? ? true : false
  end
end
