module Braintree::Queries
  class Query
    def self.exec(*args, **kargs)
      new(*args, **kargs).exec do |op, tx|
        yield op, tx
      end
    end
  end
end

alias BTQ = Braintree::Queries

require "./queries/**"
