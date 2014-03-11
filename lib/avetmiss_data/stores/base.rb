class AvetmissData::Stores::Base
  class_attribute :file_name, :parser, :builder, :attribute_names

  def self.nat_file(file_name, mapping)
    self.file_name = file_name
    self.parser = AvetmissData::Parser.new(mapping)
    self.builder = AvetmissData::Builder.new(mapping)
    self.attribute_names = mapping.keys
    attr_accessor *attribute_names
  end

  def self.from_line(line)
    new(parser.parse(line))
  end

  def initialize(attributes = {})
    self.attributes = attributes
  end

  def attributes
    Hash[self.attribute_names.map { |attr| [attr, send(attr)] }]
  end

  def attributes=(attributes)
    attributes.each_pair do |attr, value|
      send("#{attr}=", value)
    end
  end

  def to_line
    builder.build(attributes)
  end
end
