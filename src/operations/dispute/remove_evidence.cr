class Braintree::Dispute::RemoveEvidence < Braintree::Operation
  def initialize(dispute_id, evidence_id)
    @request = HTTP::Request.new(
      method: "DELETE",
      resource: "/merchants/#{BT.config.merchant}/disputes/#{dispute_id}/evidence/#{evidence_id}"
    )
  end
end
