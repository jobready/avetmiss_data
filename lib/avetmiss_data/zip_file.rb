class AvetmissData::ZipFile
  attr_accessor :path, :stores

  def initialize(path)
    @path = path
    @stores = {}
    build_archive
  end

  def build_archive
    Zip::Archive.open(path) do |zf|
      size = zf.count
      file_count = 0
      zf.each_with_index do |_, index|
        file_name = zf.get_name(size - index - 1)
        zf.fopen(file_name) do |f|
          content = f.read
          if content.present?
            file_count += 1
            build_store(file_name.gsub(/\.txt$/, ''), content.lines)
          end
        end
      end
    end
  end

  def build_store(file_name, lines)
    store_klass = file_name_to_store(file_name)
    stores[file_name] = lines.map { |line| store_klass.from_line(line) }
  end


  def file_name_to_store(file_name)
    AvetmissData::Stores::Base.subclasses.find { |store| store.file_name == file_name.to_s }
  end

end
