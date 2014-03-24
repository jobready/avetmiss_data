class AvetmissData::V7::Package < AvetmissData::Package
  def zip_file_to_stores(path)
    AvetmissData::ZipFile.new(path, "7.0").stores
  end
end
