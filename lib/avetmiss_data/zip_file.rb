class AvetmissData::ZipFile
  attr_accessor :path, :package

  def initialize(path, package = nil)
    @path = path
    @package = package
  end

  def read_archive
    Zip::Archive.open(path) do |archive|
      archive.each do |file|
        yield file
      end
    end
  end

  def build_stores(file_name, lines, package)
    store_klass = AvetmissData::Stores::Base.file_name_to_store(file_name)
    lines.map.each_with_index { |line, i| store_klass.from_line(line, i + 1, package) }
  end

  def stores
    @stores = {}
    read_archive do |file|
      content = file.read
      next unless content

      name = file.name.gsub(/\.txt$/, '')
      @stores[name] = build_stores(name, content.lines, package)
    end
    @stores
  end
end
