class AvetmissData::Stores::Base
  class_attribute :file_format, :file_name, :attrs

  def self.nat_file(file_name, mapping)
    self.file_name = file_name
    self.file_format = mapping
    self.attrs = mapping.keys
    attr_accessor *attrs
  end

  def initialize(record)
    self.class.parse(record).each_pair { |attr, value| send("#{attr}=", value) }
  end

  def file_format_hash
    self.class.file_format
  end

  def self.parse(record)
    Hash[file_format.map do |attr, range|
      value = record[range].try(:strip)
      [attr, value]
    end]
  end

  def self.max_record
    file_format.values.map { |(range, _)| range.last }.max
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
