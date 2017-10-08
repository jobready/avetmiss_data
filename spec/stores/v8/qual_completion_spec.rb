require 'spec_helper'

describe AvetmissData::Stores::V8::QualCompletion do
  context 'NAT File' do
    specify { expect(AvetmissData::Stores::V8::QualCompletion.file_name).not_to be_blank }
    specify { expect(AvetmissData::Stores::V8::QualCompletion.file_name).to eq('NAT00130') }
  end

  context 'v8 NAT00130 record' do
    let!(:line) { File.open(file_path).first }
    subject { AvetmissData::Stores::V8::QualCompletion.from_line(line) }

    context 'when the record is valid' do
      let(:file_path) { 'spec/fixtures/nat_files/v8/NAT00130.txt' }

      specify { expect(subject).not_to be_blank }
      specify { expect(subject.training_organisation_identifier).to eq('01010') }
      specify { expect(subject.qualification_identifier).to eq('UTE31206') }
      specify { expect(subject.client_identifier).to eq('12345') }
      specify { expect(subject.program_completed_date).to eq('04032013') }
      specify { expect(subject.qualification_issued_flag).to eq('Y') }
      specify { expect(subject.extras).to eq('extra data that we ignore') }
    end

    context 'when the record is invalid' do
      let(:file_path) { 'spec/fixtures/nat_files/v8/NAT00060_invalid.txt' }
      specify { expect(subject).not_to be_blank }
    end
  end
end
