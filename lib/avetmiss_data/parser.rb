class AvetmissData::Parser
  attr_accessor :file_format

  def initialize(file_format)
    @file_format = file_format
  end

  def parse(line)
    Hash[file_format.map do |attr, range|
      value = line[range].try(:strip)
      [attr, value]
    end]
  end
end
