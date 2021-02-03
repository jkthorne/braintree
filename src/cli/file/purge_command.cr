class Braintree::CLI::FilePurgeCommand
  def self.run(cli)
    Dir.new(BT.data_dir).each do |child|
      File.delete(child)
      Log.debug { "Successfully deleted File(#{child})" }
    end

    cli.human_io.puts("Successfully purged data".colorize(:green)) if cli.human_tty?
  end
end
