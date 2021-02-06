class Braintree::CLI::FilePurgeCommand
  def self.run(cli)
    files = Dir.children(BT.data_dir)

    files.each do |child|
      File.delete(BT.data_dir / child)
      Log.debug { "Successfully deleted File(#{child})" }
    end

    if cli.human_tty?
      cli.human_io.puts("Successfully purged data".colorize(:green))
      cli.human_io.puts("#{files.size} records deleted".colorize(:green))
    end
  end
end
