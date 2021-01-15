module Braintree
  class Transaction
    class XMLBuilder
      getter xml : XML::Builder

      def initialize(@xml)
      end

      def self.build(xml)
        builder = new(xml)
        yield builder
        builder
      end

      macro method_missing(call)
        m_name = {{ call.name.stringify }}.tr("_", "-")

        {% if 1 == call.args.size %}
          xml.element(m_name) { xml.text {{ call.args.first }} }
        {% elsif call.block %}
          xml.element(m_name) { yield }
        {% else %}
          raise ArgumentError.new("wrong number of arguments")
        {% end %}
      end
    end

    getter amount : String
    getter credit_card : NamedTuple(number: String, expiration_date: String)

    def initialize(@amount, @credit_card : NamedTuple(number: String, expiration_date: String))
    end

    def self.create(*args, **kargs)
      CreateTransaction.exec(*args, **kargs) do |op, tx|
        yield op, tx
      end
    end

    def self.create(*args, **kargs)
      CreateTransaction.exec(*args, **kargs) do |op, tx|
        if tx
          puts "Dispute Created with id #{tx.dig("transaction", "disputes", 0, "id")}"
        else
          puts "Failed to create"
        end
      end
    end

    # Generates a valid set of params for a transaction
    def self.factory_params(amount : String?, number : String?, expiration_date : Time?)
      amount          ||= "#{rand(12..10_000)}.12"
      number          ||= Braintree::Test::CreditCardNumbers::Disputes::CHARGEBACK
      expiration_date ||= Time.utc.shift(months: rand(3..36))
      {
        amount: amount,
        credit_card: {
          number: number,
          expiration_date: "%02d/%s" % [expiration_date.month, expiration_date.year],
        }
      }
    end
  end
end
