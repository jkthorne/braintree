class Braintree::Operations::Dispute::AddTextEvidence < BTO::Operation
  getter dispute_id : String
  getter content : String

  def initialize(@dispute_id, @content)
    @request = HTTP::Request.new(
      method: "GET",
      resource: "/merchants/#{BT.settings.merchant}/disputes/#{dispute_id}/evidence",
      body: Braintree.xml { |t|
        t.evidence {
          t.comments content
        }
      }
    )
  end

  # def self.exec(*args, **kargs)
  #   new(*args, **kargs).exec do |op, tx|
  #     yield op, tx
  #   end
  # end

  def exec
    response = Braintree.http.exec(request.not_nil!) ## TODO: remove nil check
    @response = response

    yield self, response.success? ? JSON.parse(response.body) : nil
  end
end
