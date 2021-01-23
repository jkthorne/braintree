class Braintree::Operations::Dispute::Sandbox::OpenDispute < BTO::Operation
  private getter amount : String
  private getter credit_card : NamedTuple(number: String, expiration_date: String)

  def initialize(@amount, @credit_card)
  end

  def self.exec(*args, **kargs)
    new(*args, **kargs).exec do |op, tx|
      yield op, tx
    end
  end

  def exec
    CreateTransaction.exec(@amount, @credit_card) do |op, tx|
      yield op, tx
    end
  end
end
