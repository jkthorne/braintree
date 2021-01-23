class Braintree::Operations::Dispute::Sandbox::WonDispute < BTO::Operation
  private getter amount : String
  private getter credit_card : NamedTuple(number: String, expiration_date: String)

  def initialize(@amount, @credit_card)
  end

  # def self.exec(*args, **kargs)
  #   new(*args, **kargs).exec do |op, tx|
  #     yield op, tx
  #   end
  # end

  def exec
    CreateTransaction.new(amount, credit_card).exec do |op, tx|
      if op.success? && tx
        dispute_id = tx.dig("transaction", "disputes", 0, "id").as_s
        AddTextEvidence.new(dispute_id, "compelling_evidence").exec do |op, e|
          if op.success?
            Finalize.new(dispute_id).exec do |op, d|
              if op.success? && d
                yield op, d
              else
                yield op, d
              end
            end
          else
            yield op, e
          end
        end
      else
        yield op, tx
      end
    end
  end
end