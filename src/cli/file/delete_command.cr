class Braintree::CLI::FileDeleteCommand
  def self.run(cli)
    exit_code = 0

    cli.object_ids.each do |file_id|
      path = (BT.data_dir / "#{file_id}.xml").to_s

      if File.exists?(path)
        File.delete(path)
        cli.human_io.puts "Successfully deleted File(#{file_id})".colorize(:green) if cli.human_tty?
      else
        exit_code = 1
        cli.human_io.puts "Failed to delte File(#{file_id})".colorize(:red)
      end
    end

    exit exit_code
  end
end
