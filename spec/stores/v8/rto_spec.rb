require 'spec_helper'
require_relative '../../support/store_examples'

describe AvetmissData::Stores::V8::Rto do
  context 'NAT File' do
    specify { expect(described_class.file_name).not_to be_blank }
    specify { expect(described_class.file_name).to eq('NAT00010') }
  end

  describe 'v8 NAT00010 Record' do
    let!(:line) { File.open(file_path).first }
    subject { described_class.from_line(line) }

    context 'when the record is valid' do
      context 'and has no extra fields' do

        context 'and has no trailing whitespace' do
          let(:file_path) { 'spec/fixtures/nat_files/v8/NAT00010.txt' }

          specify { expect(subject).not_to be_blank }
          specify { expect(subject.training_organisation_identifier).to eq('12345') }
          specify { expect(subject.training_organisation_name).to eq('JobReady Solutions') }
          specify { expect(subject.extras).to be_blank }
        end

        context 'and has trailing whitespace' do
          let(:file_path) { 'spec/fixtures/nat_files/v8/NAT00010_no_trailing_whitespace.txt' }
          subject { described_class.from_line(line) }

          specify { expect(subject).not_to be_blank }
          specify { expect(subject.training_organisation_identifier).to eq('12345') }
          specify { expect(subject.training_organisation_name).to eq('JobReady Solutions') }
          specify { expect(subject.extras).to be_blank }
        end
      end

      context 'and has extra fields' do
        let(:file_path) { 'spec/fixtures/nat_files/v8/NAT00010_extrafields.txt' }
        subject { described_class.from_line(line) }
        specify { expect(subject).not_to be_blank }
        specify { expect(subject.extras).not_to be_blank }
      end
    end

    it_behaves_like :store_processing_invalid_file
  end
end
