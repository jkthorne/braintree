class Braintree::Operations::DocumentUpload < BTO::Operation
  getter dispute_id : String
  getter file_path : Path

  def initialize(@dispute_id, file_path)
    @file_path = Path[file_path]
    unless File.exists?(@file_path)
      STDERR.puts "File for upload does not exist"
      exit 1
    end

    # {"document_upload[kind]"=>"evidence_document"}
    # @request = HTTP::Request.new(
    #   method: "POST",
    #   resource: "/merchants/#{dispute_id}/document_uploads"
    # )
  end

  def self.exec(*args, **kargs)
    new(*args, **kargs).exec do |op, tx|
      yield op, tx
    end
  end

  def exec
    response = nil

    IO.pipe do |reader, writer|
      channel = Channel(String).new(1)

      spawn do
        HTTP::FormData.build(writer, Time.utc.to_unix_ms.to_s) do |formdata|
          channel.send(formdata.content_type)

          formdata.field("document_upload[kind]", "evidence_document")
          File.open(@file_path) do |file|
            metadata = HTTP::FormData::FileMetadata.new(filename: @file_path.basename)
            headers = HTTP::Headers{"Content-Type" => "image/png"}
            formdata.file("file", file, metadata, headers)
          end
        end

        writer.close
      end

      headers = HTTP::Headers{"Content-Type" => channel.receive}
      response = Braintree.http.post(
        path: "/merchants/#{BT.settings.merchant}/document_uploads",
        body: reader,
        headers: headers
      )
    end

    @response = response
    yield self, response.not_nil!.success? ? Models::Document.new(XML.parse(response.not_nil!.body)) : nil
  end
end
