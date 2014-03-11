class AvetmissData::Builder
  attr_accessor :file_format

  def initialize(file_format)
    @file_format = file_format
  end

  def max_line
    file_format.values.map { |(range, _)| range.last }.max
  end

  def build(attributes)
    str = ' ' * max_line
    file_format.each_pair do |attr, (range, _)|
      str[range] = attributes[attr].to_s.ljust(range.last - range.first, ' ')
    end
    str
  end
end
