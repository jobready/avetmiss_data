# Represents a zip file containing 10 text files (corresponding to the 10 Store classes), each text file
# containing a number of lines of data (one Store per line).
class AvetmissData::ZipFile
  attr_accessor :path, :version

  def initialize(path, version = "7.0")
    @path = path
    @version = version
  end

  def read_archive
    Zip::Archive.open(path) do |archive|
      archive.each do |file|
        yield file
      end
    end
  end

  def base_store_klass
    case version
    when "6.1"
      AvetmissData::Stores::V6::Base
    when "7.0"
      AvetmissData::Stores::V7::Base
    end
  end

  def build_stores(file_name, lines)
    store_klass = base_store_klass.file_name_to_store(file_name)
    if store_klass.nil?
      raise "Unable to locate store class inheriting from #{base_store_klass.name} for file '#{file_name}'"
    end
    lines.map.each_with_index { |line, i| store_klass.from_line(line, i + 1) }
  end

  def stores
    @stores = {}
    read_archive do |file|
      content = file.read
      name = store_name_for(file.name)
      if content.nil?
        @stores[name] = []
      else
        @stores[name] = build_stores(name, content.lines)
      end
    end
    @stores
  end

  def store_name_for(filename)
    filename.upcase.gsub(/\.txt\Z/i, '')
  end
end
