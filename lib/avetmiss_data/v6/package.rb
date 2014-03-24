class AvetmissData::V6::Package < AvetmissData::Package
  def zip_file_to_stores(path)
    AvetmissData::ZipFile.new(path, "6.1").stores
  end
end
