require 'spec_helper'

describe AvetmissData::Stores::Disability do
  context 'imports the NAT00090 file' do

    context 'NAT File' do
      specify { expect(AvetmissData::Stores::Disability.file_name).not_to be_blank }
      specify { expect(AvetmissData::Stores::Disability.file_name).to eq('NAT00090') }
    end

    context 'NAT Record Parse' do
      let!(:record) { File.open('spec/fixtures/nat_files/NAT00090.txt').first }
      subject { build :store_disability, record: record }

      specify { expect(subject).not_to be_blank }
      specify { expect(subject.client_identifier).to eq('12345') }
      specify { expect(subject.disability_type_identifier).to eq('13') }
      specify { expect(subject.extras).to be_blank }
    end
  end
end
