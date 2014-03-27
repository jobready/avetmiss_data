# TODO
class AvetmissData::Stores::V6::Base < AvetmissData::Stores::Base
  def self.version
    "6.1"
  end

  def self.version_constant
    "V6"
  end

  def self.file_name_to_store(file_name)
    AvetmissData::Stores::V6::Base.subclasses.find { |store| store.file_name == file_name.to_s }
  end
end
