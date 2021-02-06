class Braintree::CLI::FileListCommand
  def self.run(cli)
    files = Dir.children(BT.data_dir)

    files.each do |child|
      if cli.human_tty?
        cli.human_io.puts "Found File(#{File.basename(child, ".xml")})".colorize(:green)
      else
        cli.data_io.puts child
      end
    end

    cli.human_io.puts("Successfully found #{files.size} records".colorize(:green)) if cli.human_tty?
  end
end
