class Braintree::CLI::FileListCommand
  def self.run(cli)
    Dir.new(BT.data_dir).each do |child|
      if cli.human_tty?
        cli.human_io.puts "Found File(#{child})".colorize(:green)
      else
        cli.data_io.puts child
      end
    end
  end
end
