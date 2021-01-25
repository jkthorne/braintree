class Braintree::Operations::Dispute::AddTextEvidence < BTO::Operation
  getter dispute_id : String
  getter content : String

  def initialize(@dispute_id, @content)
  end

  def self.exec(*args, **kargs)
    new(*args, **kargs).exec do |op, tx|
      yield op, tx
    end
  end

  def exec
    ## TODO: move to @request
    request = HTTP::Request.new(
      method: "POST",
      resource: "/merchants/#{BT.settings.merchant}/disputes/#{dispute_id}/evidence",
      body: Braintree.xml { |t|
        t.evidence {
          t.comments content
        }
      }
    )

    response = Braintree.http.exec(request)
    @response = response
    yield self, response.success? ? XML.parse(response.body) : nil
  end
end
