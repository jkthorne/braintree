module Braintree::Operations
  class ChargePaymentMethod < Mutation
    getter amount : String
    getter payment_method : String
    getter transaction_fields : Array(Symbol)?

    def initialize(@payment_method, @amount, @transaction_fields = nil)
    end

    private def query_string
      String.build do |io|
        io << "mutation chargePaymentMethod($input: ChargePaymentMethodInput!) { "
        io << "chargePaymentMethod(input: $input) { transaction { "
        if transaction_fields
          transaction_fields.not_nil!.each do |field|
            io << field
            io << ' '
          end
        end
        io << "} } }"
      end
    end

    def variables_builder(json)
      json.field "input" do
        json.object do
          json.field "paymentMethodId", payment_method
          json.field "transaction" do
            json.object do
              json.field "amount", amount
            end
          end
        end
      end
    end
  end
end
