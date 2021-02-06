class Braintree::CLI::DisputeEvidenceCommand
  def self.run(cli)
    unless cli.options.has_key?(:text) || cli.options.has_key?(:file) || cli.options.has_key?(:remove)
      cli.human_io.puts "Used the evidence command with invalid parameters"
      cli.human_io.puts "Use the Text, File, or Remove command"
    end

    if cli.options[:text]?
      execute_text(cli)
    elsif cli.options[:file]?
      execute_file(cli)
    elsif cli.options[:remove]?
      execute_remove(cli)
    end

    cli.human_io.puts "failure in evidence command please open an issue"
    exit 1
  end

  def self.execute_text(cli)
    success = true

    cli.object_ids.each do |dispute_id|
      Braintree::Operations::Dispute::AddTextEvidence.exec(dispute_id, cli.options[:text]) do |op, evidence|
        if evidence
          evidence.store
          cli.human_io.puts "dispute(#{dispute_id}) now has evidence(#{evidence.id})"
        else
          success = false
          cli.human_io.puts "failed to add evidence to dispute(#{dispute_id})"
        end
      end
    end

    exit success ? 0 : 1
  end

  def self.execute_file(cli)
    success = true

    cli.object_ids.each do |dispute_id|
      BTO::DocumentUpload.exec(dispute_id, cli.options[:file]) do |op, document|
        if document
          document.store
          cli.human_io.puts "Document(#{document.id}) successfully uploaded"
          BTO::Dispute::AddFileEvidence.new(dispute_id, document.id).exec do |op, evidence|
            if evidence
              evidence.store
              cli.human_io.puts "Successfuly added Evidence(#{evidence.id}) to Dispute(#{dispute_id})"
            else
              success = false
              cli.human_io.puts "Failed to add Evidence to Dispute(#{dispute_id})"
            end
          end
        else
          success = false
          cli.human_io.puts "failed to upload Document"
        end
      end
    end

    exit success ? 0 : 1
  end

  def self.execute_remove(cli)
    success = true

    cli.object_ids.each do |dispute_id|
      BTO::Dispute::RemoveEvidence.new(dispute_id, cli.options[:remove]).exec do |op, evidence|
        if evidence
          cli.human_io.puts "Successfuly removed Evidence(#{cli.options[:remove]}) to Dispute(#{dispute_id})"
        else
          success = false
          cli.human_io.puts "Failed to remove Evidence(#{cli.options[:remove]}) to Dispute(#{dispute_id})"
        end
      end
    end

    exit success ? 0 : 1
  end
end
