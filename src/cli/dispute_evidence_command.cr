class Braintree::CLI::DisputeEvidenceCommand
  def self.run(ids : Array(String), options : Hash(Symbol, String))
    unless options.has_key?(:text) || options.has_key?(:file) || options.has_key?(:remove)
      STDERR.puts "Used the evidence command with invalid parameters"
      STDERR.puts "Use the Text, File, or Remove command"
    end

    if options[:text]?
      execute_text(ids, options)
    elsif options[:file]?
      execute_file(ids, options)
    elsif options[:remove]?
      execute_remove(ids, options)
    end

    STDERR.puts "failure in evidence command please open an issue"
    exit 1
  end

  def self.execute_text(ids, options)
    success = true

    ids.each do |dispute_id|
      Braintree::Operations::Dispute::AddTextEvidence.exec(dispute_id, options[:text]) do |op, evidence|
        if evidence
          evidence.store
          STDERR.puts "dispute(#{dispute_id}) now has evidence(#{evidence.id})"
        else
          success = false
          STDERR.puts "failed to add evidence to dispute(#{dispute_id})"
        end
      end
    end

    exit success ? 0 : 1
  end

  def self.execute_file(ids, options)
    success = true

    ids.each do |dispute_id|
      BTO::DocumentUpload.exec(dispute_id, options[:file]) do |op, document|
        if document
          document.store
          STDERR.puts "Document(#{document.id}) successfully uploaded"
          BTO::Dispute::AddFileEvidence.new(dispute_id, document.id).exec do |op, evidence|
            if evidence
              evidence.store
              STDERR.puts "Successfuly added Evidence(#{evidence.id}) to Dispute(#{dispute_id})"
            else
              success = false
              STDERR.puts "Failed to add Evidence to Dispute(#{dispute_id})"
            end
          end
        else
          success = false
          STDERR.puts "failed to upload Document"
        end
      end
    end

    exit success ? 0 : 1
  end

  def self.execute_remove(ids, options)
    success = true

    ids.each do |dispute_id|
      BTO::Dispute::RemoveEvidence.new(dispute_id, options[:remove]).exec do |op, evidence|
        if evidence
          STDERR.puts "Successfuly removed Evidence(#{options[:remove]}) to Dispute(#{dispute_id})"
        else
          success = false
          STDERR.puts "Failed to remove Evidence(#{options[:remove]}) to Dispute(#{dispute_id})"
        end
      end
    end

    exit success ? 0 : 1
  end
end
