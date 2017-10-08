require 'spec_helper'
require_relative '../../support/store_examples'

describe AvetmissData::Stores::V8::QualCompletion do
  context 'NAT File' do
    specify { expect(described_class.file_name).not_to be_blank }
    specify { expect(described_class.file_name).to eq('NAT00130') }
  end

  context 'v8 NAT00130 record' do
    let!(:line) { File.open(file_path).first }
    subject { described_class.from_line(line) }

    context 'when the record is valid' do
      context 'and has no extra fields' do
        let(:file_path) { 'spec/fixtures/nat_files/v8/NAT00130.txt' }

        specify { expect(subject).not_to be_blank }
        specify { expect(subject.training_organisation_identifier).to eq('01010') }
        specify { expect(subject.qualification_identifier).to eq('UTE31206') }
        specify { expect(subject.client_identifier).to eq('12345') }
        specify { expect(subject.program_completed_date).to eq('04032013') }
        specify { expect(subject.qualification_issued_flag).to eq('Y') }
        specify { expect(subject.extras).to be_blank }
      end

      context 'and has extra fields' do
        let(:file_path) { 'spec/fixtures/nat_files/v8/NAT00130_extrafields.txt' }
        specify { expect(subject.extras).to eq('extra data that we ignore') }
      end
    end

    it_behaves_like :store_processing_invalid_file
  end
end
