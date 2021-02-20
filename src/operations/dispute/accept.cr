class Braintree::Operations::Dispute::Accept < BTO::Operation
  getter dispute_id : String

  def initialize(@dispute_id)
    @request = HTTP::Request.new(
      method: "PUT",
      resource: "/merchants/#{BT.config.merchant}/disputes/#{dispute_id}/accept"
    )
  end

  def self.exec(*args, **kargs)
    new(*args, **kargs).exec do |op, tx|
      yield op, tx
    end
  end

  def exec
    response = Braintree.http.exec(@request.not_nil!) # # TODO: remove nil check
    @response = response

    yield self, response.success? ? XML.parse(response.body) : nil
  end
end
