class Braintree::CLI::FileReadCommand
  def self.run(cli)
    exit_code = 0

    cli.object_ids.each do |file_id|
      path = (BT.data_dir / "#{file_id}.xml").to_s

      if File.exists?(path)
        unless cli.data_io.tty?
          # TODO: use io pipes
          cli.data_io.puts File.read(path)
        else
          cli.human_io.puts "Successfully read File(#{file_id})".colorize(:green)
          cli.human_io.puts File.read(path)
        end
      else
        exit_code = 1
        cli.human_io.puts "Failed to load File(#{file_id})".colorize(:red)
      end
    end

    exit exit_code
  end
end
