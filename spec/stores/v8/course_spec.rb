require 'spec_helper'
require_relative '../../support/store_examples'

describe AvetmissData::Stores::V8::Course do
  context 'NAT File' do
    specify { expect(described_class.file_name).not_to be_blank }
    specify { expect(described_class.file_name).to eq('NAT00030A') }
  end

  context 'v8 NAT00030 record' do
    let!(:line) { File.open(file_path).first }
    subject { described_class.from_line(line) }

    context 'When the record is valid' do
      context 'and has no extra fields' do
        let(:file_path) { 'spec/fixtures/nat_files/v8/NAT00030A.txt' }

        specify { expect(subject).not_to be_blank }
        specify { expect(subject.qualification_identifier).to eq('UTE31206') }
        specify { expect(subject.qualification_name).to eq('Electrotechnology Fire Protection Control') }
        specify { expect(subject.nominal_hours).to eq('0420') }
        specify { expect(subject.qualification_recognition_identifier).to eq('11') }
        specify { expect(subject.qualification_education_level_identifier).to eq('514') }
        specify { expect(subject.qualification_education_field_identifier).to eq('0313') }
        specify { expect(subject.anzsco_identifier).to eq('341111') }
        specify { expect(subject.vet_flag).to eq('N') }
        specify { expect(subject.extras).to be_blank }
      end

      context 'and has extra fields' do
        let(:file_path) { 'spec/fixtures/nat_files/v8/NAT00030A_extrafields.txt' }
        specify { expect(subject.extras).to eq('extra data that we ignore') }
      end
    end
  end

  it_behaves_like :store_processing_invalid_file
end
