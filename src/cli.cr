require "./braintree"
require "option_parser"
require "file_utils"
require "ini"
require "colorize"

# TODO: singilton
# TODO: remote as a method
class Braintree::CLI
  enum Command
    None
    Banner
    Error
    TransactionFind
    DisputeAccept
    DisputeEvidence
    DisputeCreate
    DisputeFinalize
    DisputeFind
    DisputeSearch
    FileRead
    FileWrite
    FileDelete
    FileList
    FilePurge
    ConfigSetup
  end

  Log = ::Log.for("CLI")

  
  private property options = {} of Symbol => String
  getter options = {} of Symbol => String
  private property object_ids = [] of String
  getter object_ids = [] of String
  getter input_io : IO
  getter data_io : IO
  getter human_io : IO

  def initialize(@input_io = STDIN, @data_io = STDOUT, @human_io = STDERR)
    # TODO: implement status property on cli
    BT.load_config!
  end

  def self.run
    CLI.new.run
  end

  def run
    banner = nil

    command = Command::Banner
    main_parser = OptionParser.parse do |parser|
      parser.banner = "Usage: bt [command] [switches]"
      parser.on("-h", "--help", "Prints this dialog") {
        command = Command::Banner
        banner = parser.to_s
      }
      parser.on("-v", "--version", "Print version") { puts parser }
      parser.on("-d", "--debug", "show debugging information") { ::Log.setup(:debug) }
      parser.on("-s", "--silent", "do not show human readable output") { setup_null_output }

      parser.separator("Subcommands")

      parser.on("data", "Data subcommands") do
        parser.on("-R", "--read", "reads the file with ID") { command = Command::FileRead }
        parser.on("-W DATA", "--write DATA", "writes the file with ID") do |_d|
          command = Command::FileWrite
          options[:data] = _d
        end
        parser.on("-D", "--delete", "deletes the file with ID") { command = Command::FileDelete }
        parser.on("-L", "--list", "lists all data files") { command = Command::FileList }
        parser.on("-P", "--purge", "purges all data files") { command = Command::FilePurge }

        parser.unknown_args do |pre_dash, post_dash|
          Log.debug { "File IDs pre: #{pre_dash}, post: #{post_dash}" }

          if !pre_dash.empty? || !post_dash.empty?
            command = Command::FileRead if command == Command::Banner
            object_ids.concat(pre_dash)
          end

          if !input_tty?
            ARGF.each_line do |line|
              human_io.puts "Ingested Data: #{line}"
              object_ids << line.split(ENV.fetch("FS", " "))[0]
            end
          end

          command = Command::DisputeFind if command == Command::Banner if 0 < object_ids.size
        end
      end

      parser.on("config", "Configuration subcommands") do
        parser.banner = "Usage: bt dispute create [switches]"
        parser.on("setup", "initial setup of configuration") { command = Command::ConfigSetup }
      end

      parser.on("transaction", "Transaction subcommands") do
        parser.unknown_args do |pre_dash, post_dash|
          Log.debug { "Transaction IDs pre: #{pre_dash}, post: #{post_dash}" }

          if !pre_dash.empty? || !post_dash.empty?
            command = Command::TransactionFind if command == Command::Banner
            object_ids.concat(pre_dash)
          end

          if !input_tty?
            ARGF.each_line do |line|
              human_io.puts "Ingested Transaction: #{line}"
              object_ids << line.split(ENV.fetch("FS", " "))[0]
            end
          end

          command = Command::DisputeFind if command == Command::Banner if 0 < object_ids.size
        end
      end

      parser.on("dispute", "Dispute subcommands") do
        parser.banner = "Usage: bt dispute [subcommand|ids] [switches]"
        parser.on("-h", "--help", "Prints this dialog") {
          command = Command::Banner
          banner = parser.to_s
        }
        parser.separator("Global")
        parser.on("-l", "--local", "persist/use local data") { options[:source] = "local" }
        parser.on("-r", "--remote", "only use remote date") { options[:source] = "remote" }
        parser.on("-X", "--expand", "show expanded information") { options[:data] = "expanded" }
        parser.separator("Actions")
        parser.on("-F", "--finalize", "finalizes the dispute") { command = Command::DisputeFinalize }
        parser.on("-A", "--accept", "accepts a dispute") { command = Command::DisputeAccept }

        parser.separator("Subcommands")
        parser.on("create", "create a new dispute") do
          # TODO: create a fail fast option
          command = Command::DisputeCreate
          parser.banner = "Usage: bt dispute create [switches]"
          parser.on("-h", "--help", "Prints this dialog") {
            command = Command::Banner
            banner = parser.to_s
          }
          parser.on("-n NUM", "--number NUM", "number of disputes to create") { |_n| options[:number] = _n }
          parser.separator("Attributes")
          parser.on("-a AMOUNT", "--amount AMOUNT", "set amount for dispute") { |_a| options[:amount] = _a }
          parser.on("-c CC_NUM", "--credit_card CC_NUM", "set card number for dispute") { |_c| options[:card_number] = _c }
          parser.on("-e DATE", "--exp_date DATE", "set expiration date for dispute") { |_e| options[:exp_date] = _e }
          parser.on("-S STATUS", "--status STATUS", "set expiration date for dispute (open,won,lost)") { |_s| options[:status] = _s }
        end

        parser.on("evidence", "adds file evidence") do
          command = Command::DisputeEvidence
          parser.on("-h", "--help", "Prints this dialog") {
            command = Command::Banner
            banner = parser.to_s
          }
          parser.separator("Types")
          parser.on("-t TEXT", "--text TEXT", "adds text evidenxe") { |_t| options[:text] = _t }
          parser.on("-f PATH", "--file PATH", "path to file") { |_f| options[:file] = _f }
          parser.on("-r ID", "--remove ID", "removes evidence for dispute") { |_id| options[:remove] = _id }
        end

        parser.on("search", "searches disputes") do
          command = Command::DisputeSearch
          parser.on("-h", "--help", "Prints this dialog") {
            command = Command::Banner
            banner = parser.to_s
          }
          parser.on("-X", "--expanded", "includeds transaction data") { options[:data] = "expanded" }
          parser.separator("Pagination")
          parser.on("-p NUM", "--page_num NUM", "results page number") { |_p| options[:page_num] = _p }
          parser.on("-A", "--all", "gets all results") { options[:all] = "all" }
          parser.separator("Search Criteria")
          parser.on("-a AMOUNTS", "--amount AMOUNTS", "amount_disputed range (100,200)") { |_a| options[:amounts] = _a }
          parser.on("-S STATUS", "--status STATUS", "status (open,won,lost)") { |_s| options[:status] = options[:status]? ? "#{options[:status]},#{_s}" : _s }
          parser.on("-c NUM", "--case NUM", "case number") { |_c| options[:case_number] = _c }
          parser.on("-C ID", "--customer ID", "customer id") { |_c| options[:customer_id] = _c }
          parser.on("-d DATE", "--disbursment_date DATE", "disbursment date") { |_d| options[:disbursment_date] = _d }
          parser.on("-e DATE", "--effective_date DATE", "effective date") { |_e| options[:effective_date] = _e }
          parser.on("-i ID", "--id ID", "dispute id") { |_i| options[:dispute_id] = _i }
          parser.on("-k KIND", "--kind KIND", "kind (chargeback,retrieval)") { |_k| options[:kind] = options[:kind]? ? "#{options[:kind]},#{_k}" : _k }
          parser.on("-m ID", "--merchant_account_id ID", "merchant account id") { |_k| options[:merchant_account_id] = _k }
          parser.on("-r REASON", "--reason REASON", "reason") { |_r| options[:reason] = _r }
          parser.on("-R CODE", "--reason_code CODE", "reason_code") { |_r| options[:reason_code] = _r }
          parser.on("-D DATE", "--received_date DATE", "received date") { |_r| options[:received_date] = _r }
          parser.on("-n NUM", "--reference_number NUM", "reference number") { |_r| options[:reference_number] = _r }
          parser.on("-b DATE", "--reply_by_date DATE", "reply by date") { |_r| options[:reply_by_date] = _r }
          parser.on("-t ID", "--tx_id ID", "transaction id") { |_t| options[:transaction_id] = _t }
          parser.on("-T SOURCE", "--tx_source SOURCE", "transaction source") { |_t| options[:transaction_source] = _t }
        end

        parser.unknown_args do |pre_dash, post_dash|
          Log.debug { "Dispute IDs pre: #{pre_dash}, post: #{post_dash}" }

          if !pre_dash.empty? || !post_dash.empty?
            command = Command::DisputeFind if command == Command::Banner
            object_ids.concat(pre_dash)
          end

          if !input_tty?
            ARGF.each_line do |line|
              human_io.puts "Ingested Dispute: #{line}"
              object_ids << line.split(ENV.fetch("FS", " "))[0]
            end
          end

          command = Command::DisputeFind if command == Command::Banner if 0 < object_ids.size
        end
      end

      parser.invalid_option do |flag|
        command = Command::Error
        human_io.puts "ERROR: #{flag} is not a valid option."
        human_io.puts parser
      end
    end
    banner ||= main_parser.to_s

    Log.debug { "command selected: #{command}" }
    Log.debug { "with options: #{options}" }
    Log.debug { "with ids: #{object_ids}" }
    case command
    when Command::Banner
      STDERR.puts banner
      exit
    when Command::Error
      exit 1
    when Command::FileRead
      FileReadCommand.run(self)
    when Command::FileWrite
      FileWriteCommand.run(self)
    when Command::FileDelete
      FileDeleteCommand.run(self)
    when Command::FileList
      FileListCommand.run(self)
    when Command::ConfigSetup
      BT.setup_config!
    when Command::FilePurge
      FilePurgeCommand.run(self)
    when Command::TransactionFind
      TransactionFindCommand.run(self)
    when Command::DisputeAccept
      DisputeAcceptCommand.run(object_ids)
    when Command::DisputeEvidence
      DisputeEvidenceCommand.run(object_ids, options)
    when Command::DisputeCreate
      DisputeCreateCommand.run(self)
    when Command::DisputeFinalize
      DisputeFinalizeCommand.run(object_ids)
    when Command::DisputeFind
      DisputeFindCommand.run(self)
    when Command::DisputeSearch
      DisputeSearchCommand.run(self)
    else
      human_io.puts "ERROR: you found an error in the CLI please consider submitting an issue"
      exit 1
    end
  end

  def setup_null_output
    @human_io = File.open(File::NULL, "w")
  end

  def color?
    error.tty?
  end

  def input_tty?
    input_io.tty?
  end

  def human_tty?
    human_io.tty?
  end

  def data_tty?
    data_io.tty?
  end
end

require "./cli/**"

Log.setup_from_env(default_level: :error)
BT::CLI.run
