require "xml"

puts(
XML.build(version: "1.0", encoding: "UTF-8") do |xml|
  xml.element("transaction") do
    xml.element("amount") { xml.text "10.40" }
    xml.element("credit-card") do
      xml.element("expiration-date") { xml.text "01/2022" }
      xml.element("number") { xml.text "4023898493988028" }
    end
    xml.element("type") { xml.text "sale" }
  end
end
)

# "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
# "<transaction>\n" +
# "  <amount>10.40</amount>\n" +
# "  <credit-card>\n" +
# "    <expiration-date>01/2022</expiration-date>\n" +
# "    <number>4023898493988028</number>\n" +
# "  </credit-card>\n" +
# "  <type>sale</type>\n" +
# "</transaction>\n"