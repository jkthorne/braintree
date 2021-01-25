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
      yield op, tx
    end
  end
end
