require 'spec_helper'
require_relative '../../support/store_examples'

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

  context 'NAT00090 record' do
    let!(:line) { File.open(file_path).first }
    subject { including_class.from_line(line) }

    context 'when the record is valid' do
      context 'and contains no extra fields' do
        let(:file_path) { 'spec/fixtures/nat_files/v7/NAT00090.txt' }
        specify { expect(subject).not_to be_blank }
        specify { expect(subject.client_identifier).to eq('12345') }
        specify { expect(subject.disability_type_identifier).to eq('13') }
        specify { expect(subject.extras).to be_blank }
      end

      context 'and contains extra fields' do
        let(:file_path) { 'spec/fixtures/nat_files/v7/NAT00090_extrafields.txt' }
        specify { expect(subject.extras).to eq('extra data that we ignore') }
      end
    end

    it_behaves_like :store_processing_invalid_file
  end
end
