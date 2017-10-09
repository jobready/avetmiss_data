class AvetmissData::Errors::UnknownVersionError < StandardError
  def initialize(version)
    super("Unknown NAT Version: #{version}")
  end
end
