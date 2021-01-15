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
  end
end
