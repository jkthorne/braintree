class Braintree::CLI::DisputeFindCommand
  def self.exec(options : Hash(Symbol, String))
    BTQ::Dispute::Find.exec(options[:dispute_id]) do |op, d|
      if d
        puts "dispute found" ## TODO output more data
      else
        STDERR.puts "failed to find dispute"
        exit 1
      end
    end
  end
end
