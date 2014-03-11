class AvetmissData::Parser
  attr_accessor :file_format
  attr_accessor :attributes

  def initialize(file_format)
    @file_format = file_format
  end

  def parse(record)
    @attributes = Hash[file_format.map do |attr, range|
      value = record[range].try(:strip)
      [attr, value]
    end]
  end
end
