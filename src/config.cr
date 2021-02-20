class Braintree::Config
  STAGING_URI = URI.parse("https://api.sandbox.braintreegateway.com:443/")
  PRODUCTION_URI = URI.parse("https://api.braintreegateway.com:443/")

  private property profile : String
  getter profile : String
  getter enviroment : String?
  getter host : URI?
  getter merchant : String?
  getter public_key : String?
  getter private_key : String?

  def initialize(@profile, @enviroment = nil, @merchant = nil, @public_key = nil, @private_key = nil, host = nil)
    host ||= ENV["BT_HOST"]?
    @host ||= URI.parse(host) if host

    @enviroment ||= ENV["BT_ENVIROMENT"]?
    @merchant ||= ENV["BT_MERCHANT"]?
    @public_key ||= ENV["BT_PUBLIC_KEY"]?
    @private_key ||= ENV["BT_PRIVATE_KEY"]?

    if @merchant.nil? || @enviroment.nil? || @public_key.nil? || @private_key.nil?
      path = (config_dir / "#{profile}.ini")

      if File.exists?(path.to_s)
        config = INI.parse(File.read(path.to_s))
        host ||= config.dig("braintree", "host")

        @enviroment ||= config.dig("braintree", "enviroment")
        @host ||= URI.parse(host) if host
        @merchant ||= config.dig("braintree", "merchant")
        @public_key ||= config.dig("braintree", "public_key")
        @private_key ||= config.dig("braintree", "private_key")
      end
    end
  end

  def config_dir
    path = BT.home_dir / ".config" / "bt"
    FileUtils.mkdir_p(path.to_s) if !File.exists?(path.to_s)
    path
  end

  def load : self
    path = (config_dir / "#{profile}.ini")

    if File.exists?(path.to_s)
      config = INI.parse(File.read(path.to_s))

      @enviroment = config.dig("braintree", "enviroment")
      @host = config.dig("braintree", "host")
      @merchant = config.dig("braintree", "merchant")
      @public_key = config.dig("braintree", "public_key")
      @private_key = config.dig("braintree", "private_key")
    end

    self
  end

  def save : self
    path = (config_dir / "#{profile}.ini")
    config = {} of String => String

    config["enviroment"] = enviroment
    config["host"] = host.to_s
    config["merchant"] = merchant
    config["public_key"] = public_key
    config["private_key"] = private_key

    File.write(path.to_s, INI.build({"braintree" => config}))

    self
  end

  def setup : self
    path = (config_dir / "#{profile}.ini").expand(home: true)

    print "Enter enviroment:"
    @enviroment = gets.to_s
    print "Enter merchant id: "
    @merchant = gets.to_s
    print "Enter public key: "
    @public_key = gets.to_s
    print "Enter private key: "
    @private_key = gets.to_s

    save
  end

  def host : URI
    if host = @host
      return host
    end

    case enviroment
    when "sandbox"
      return STAGING_URI
    when "production"
      return PRODUCTION_URI
    end

    raise "Config(#{profile}) does not have host loaded. \
           to configure host you can run the command.    \
           # bt config --host YOUR_HOST"
  end

  def enviroment : String
    if enviroment = @enviroment
      return enviroment
    else
      raise "Config(#{profile}) does not have enviroment loaded. \
            to configure enviroment you can run the command.    \
            # bt config --enviroment YOUR_ENVIROMENT"
    end
  end

  def merchant : String
    if merchant = @merchant
      return merchant
    else
      raise "Config(#{profile}) does not have merchant loaded. \
            to configure merchant you can run the command.    \
            # bt config --merchant YOUR_MERCHANT"
    end
  end

  def public_key : String
    if public_key = @public_key
      return public_key
    else
      raise "Config(#{profile}) does not have public_key loaded. \
            to configure public_key you can run the command.    \
            # bt config --public_key YOUR_PUBLIC_KEY"
    end
  end

  def private_key : String
    if private_key = @private_key
      return private_key
    else
      raise "Config(#{profile}) does not have private_key loaded. \
            to configure private_key you can run the command.    \
            # bt config --private_key YOUR_PRIVATE_KEY"
    end
  end
end