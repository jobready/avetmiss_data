class AvetmissData::Stores::V8::Base < AvetmissData::Stores::Base
  def self.version
    "8.0"
  end

  def self.version_constant
    "V8"
  end

  def self.file_name_to_store(file_name)
    AvetmissData::Stores::V8::Base.subclasses.find { |store| store.file_name == file_name.to_s }
  end
end
