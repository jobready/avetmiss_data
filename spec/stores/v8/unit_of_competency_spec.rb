require 'spec_helper'
require_relative '../../support/store_examples'

describe AvetmissData::Stores::V8::UnitOfCompetency do
  context 'NAT File' do
    specify { expect(described_class.file_name).not_to be_blank }
    specify { expect(described_class.file_name).to eq('NAT00060') }
  end

  describe 'v8 NAT00060 record' do
    let!(:line) { File.open(file_path).first }
    subject { described_class.from_line(line) }

    context 'when the record is valid' do
      context 'and has no extra fields' do
        let!(:file_path) { 'spec/fixtures/nat_files/v8/NAT00060.txt' }

        specify { expect(subject).not_to be_blank }
        specify { expect(subject.unit_competency_identifier).to eq('AE1') }
        specify { expect(subject.unit_competency_name).to eq('Academic English 1') }
        specify { expect(subject.unit_competency_education_field_identifier).to eq('000000') }
        specify { expect(subject.vet_flag).to eq('N') }
        specify { expect(subject.nominal_hours).to eq('0025') }
        specify { expect(subject.extras).to be_blank }
      end

      context 'and has extra fields' do
        let!(:file_path) { 'spec/fixtures/nat_files/v8/NAT00060_extrafields.txt' }
        specify { expect(subject.extras).to eq('extra data that we ignore') }
      end
    end

    it_behaves_like :store_processing_invalid_file
  end
end
