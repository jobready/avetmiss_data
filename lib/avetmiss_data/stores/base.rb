class AvetmissData::Stores::Base
  class_attribute :file_name, :attrs
  attr_accessor :attributes

  def self.nat_file(file_name, mapping)
    self.parser = AvetmissData::Parser.new(mapping)
    self.file_name = file_name
    self.attrs = mapping.keys
    attr_accessor *attrs
  end

  def initialize(record=nil)
    self.attributes = parser.parse(record).attributes if record
  end

  def file_format_hash
    parser.file_format
  end

  def attributes=(record)
    @attributes = record

    record.each_pair do |attr, value|
      send("#{attr}=", value)
    end
  end

  def self.max_record
    file_format_hash.values.map { |(range, _)| range.last }.max
  end

  def to_record
    self.class.to_record(Hash[attrs.map { |attr| [attr, send(attr)] }])
  end

  def self.to_record(values)
    str = ' ' * max_record
    file_format.each_pair do |attr, (range, _)|
      str[range] = values[attr].to_s.ljust(range.last - range.first, ' ')
    end
    str
  end
end
