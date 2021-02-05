class Braintree::CLI::FilePurgeCommand
  def self.run(cli)
    Dir.children(BT.data_dir).each do |child|
      File.delete(BT.data_dir / child)
      Log.debug { "Successfully deleted File(#{child})" }
    end

    cli.human_io.puts("Successfully purged data".colorize(:green)) if cli.human_tty?
  end
end
