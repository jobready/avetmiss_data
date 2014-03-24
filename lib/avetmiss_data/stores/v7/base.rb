class AvetmissData::Stores::V7::Base < AvetmissData::Stores::Base
  def self.file_name_to_store(file_name)
    AvetmissData::Stores::V7::Base.subclasses.find { |store| store.file_name == file_name.to_s }
  end
end
