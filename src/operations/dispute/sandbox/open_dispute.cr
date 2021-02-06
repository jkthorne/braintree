class Braintree::Operations::Dispute::Sandbox::OpenDispute < BTO::Operation
  private getter amount : String
  private getter card_number : String
  private getter card_expiration : String

  def initialize(@amount, @card_number, @card_expiration)
  end

  def self.exec(*args, **kargs)
    new(*args, **kargs).exec do |op, tx|
      yield op, tx
    end
  end

  def exec
    CreateTransaction.new(@amount, @card_number, @card_expiration).exec do |op, tx|
      disputes = tx.try(&.disputes)
      dispute_count = disputes.try(&.size)
      if 0 < (dispute_count || 0)
        yield op, disputes.not_nil!.first
      else
        yield op, nil
      end
    end
  end
end
