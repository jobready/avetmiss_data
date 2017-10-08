require 'spec_helper'

describe AvetmissData::Stores::V7V8Disability do
  let(:including_class) do
    Class.new(AvetmissData::Stores::Base) do
      include AvetmissData::Stores::V7V8Disability
    end
  end

  context 'NAT File' do
    specify { expect(including_class.file_name).not_to be_blank }
    specify { expect(including_class.file_name).to eq('NAT00090') }
  end

  context 'imports the NAT00090 file' do
    let!(:line) { File.open(file_path).first }
    subject { including_class.from_line(line) }

    context 'NAT Record Parse' do
      let(:file_path) { 'spec/fixtures/nat_files/v7/NAT00090.txt' }
      specify { expect(subject).not_to be_blank }
      specify { expect(subject.client_identifier).to eq('12345') }
      specify { expect(subject.disability_type_identifier).to eq('13') }
      specify { expect(subject.extras).to be_blank }
    end
  end
end
