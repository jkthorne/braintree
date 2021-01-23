require "csv"

csv = CSV.new(File.read("./tmp.csv"), quote_char: '+')

csv.each do |row|
  puts(
    "
    # Generate an amount for a #{row[3]} declined transaction #{row[1]}
    #
    # #{row[2].strip}
    # more info: https://developers.braintreepayments.com/reference/general/processor-responses/authorization-responses#code-#{row[0]}
    def self.#{
      row[1].strip.split(" ").map(&.capitalize).join.tr("'", "").underscore
    }
      rand(#{row[0]}.00..#{row[0]}.99)
    end
    "
  )
end