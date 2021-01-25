class Braintree::Operations::Dispute::Sandbox::WonDispute < BTO::Operation
  private getter amount : String
  private getter card_number : String
  private getter card_expiration : String

  def initialize(@amount, @card_number, @card_expiration)
    ## TODO: add state managment (State)
  end

  def self.exec(*args, **kargs)
    new(*args, **kargs).exec do |op, tx|
      yield op, tx
    end
  end

  def exec
    CreateTransaction.new(@amount, @card_number, @card_expiration).exec do |op, tx|
      if op.success? && tx
        dispute_id = tx.not_nil!.xpath_node("//transaction/disputes[1]/dispute/id").not_nil!.text
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