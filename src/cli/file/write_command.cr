class Braintree::CLI::FileWriteCommand
  def self.run(cli)
    exit_code = 0

    cli.object_ids.each do |file_id|
      path = (BT.data_dir / "#{file_id}.xml").to_s

      if File.exists?(path)
        File.write(path, cli.options[:data]?)
        if cli.human_io.tty?
          cli.human_io.puts "Wite to File(#{file_id})".colorize(:green)
        end
      else
        exit_code = 1
        cli.human_io.puts "Failed to write File(#{file_id})".colorize(:red)
      end
    end

    exit exit_code
  end
end
