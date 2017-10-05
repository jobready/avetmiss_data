require 'spec_helper'

describe AvetmissData::Stores::V8::Rto do
  let!(:line) { File.open(file_path).first }

  describe 'v8 NAT00010 Record' do
    context 'when the record is valid' do
      let(:file_path) { 'spec/fixtures/nat_files/v8/NAT00010.txt' }
      context 'NAT File' do
        specify { expect(AvetmissData::Stores::V8::Rto.file_name).not_to be_blank }
        specify { expect(AvetmissData::Stores::V8::Rto.file_name).to eq('NAT00010') }
      end

      context 'v8 NAT Record Parse' do
        subject { AvetmissData::Stores::V8::Rto.from_line(line) }

        specify { expect(subject).not_to be_blank }
        specify { expect(subject.training_organisation_identifier).to eq('12345') }
        specify { expect(subject.training_organisation_name).to eq('JobReady Solutions') }
        specify { expect(subject.extras).to be_blank }
      end

      context 'v8 NAT Record Parse Without Trailing White Space' do
        let(:file_path) { 'spec/fixtures/nat_files/v8/NAT00010_no_trailing_whitespace.txt' }
        subject { AvetmissData::Stores::V8::Rto.from_line(line) }

        specify { expect(subject).not_to be_blank }
        specify { expect(subject.training_organisation_identifier).to eq('12345') }
        specify { expect(subject.training_organisation_name).to eq('JobReady Solutions') }
        specify { expect(subject.extras).to be_blank }
      end

      context 'record with data collection fields' do
        let(:file_path) { 'spec/fixtures/nat_files/v8/NAT00010_extrafields.txt' }
        subject { AvetmissData::Stores::V8::Rto.from_line(line) }
        specify { expect(subject).not_to be_blank }
        specify { expect(subject.extras).not_to be_blank }
      end
    end

    context 'when the record is invalid' do
      let(:file_path) { 'spec/fixtures/nat_files/v8/NAT00010_invalid.txt' }
      subject { AvetmissData::Stores::V8::Rto.from_line(line) }
      specify { expect(subject).not_to be_blank }
    end
  end
end
