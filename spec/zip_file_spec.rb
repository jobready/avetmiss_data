require 'spec_helper'

describe AvetmissData::ZipFile do
  context 'read a zip file' do
    let!(:zip_file) { build :zip_file, io: File.open('spec/fixtures/zip_files/valid.zip') }

  end
end
