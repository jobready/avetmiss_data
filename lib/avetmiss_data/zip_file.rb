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
    lines.map.each_with_index { |line, i| store_klass.from_line(line, i + 1) }
  end

  def stores
    @stores = {}
    read_archive do |file|
      content = file.read
      next unless content

      name = file.name.gsub(/\.txt$/, '').upcase
      @stores[name] = build_stores(name, content.lines)
    end
    @stores
  end
end
