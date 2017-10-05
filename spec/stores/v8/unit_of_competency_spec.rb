require 'spec_helper'

describe AvetmissData::Stores::V8::UnitOfCompetency do
  context 'NAT File' do
    specify { expect(AvetmissData::Stores::V8::UnitOfCompetency.file_name).not_to be_blank }
    specify { expect(AvetmissData::Stores::V8::UnitOfCompetency.file_name).to eq('NAT00060') }
  end

  describe 'v8 NAT00060 record' do
    let!(:line) { File.open(file_path).first }
    subject { AvetmissData::Stores::V8::UnitOfCompetency.from_line(line) }

    context 'when the record is valid' do
      context 'NAT Record Parse' do
        let!(:file_path) { 'spec/fixtures/nat_files/v8/NAT00060.txt' }

        specify { expect(subject).not_to be_blank }
        specify { expect(subject.unit_competency_identifier).to eq('AE1') }
        specify { expect(subject.unit_competency_name).to eq('Academic English 1') }
        specify { expect(subject.unit_competency_education_field_identifier).to eq('000000') }
        specify { expect(subject.vet_flag).to eq('N') }
        specify { expect(subject.nominal_hours).to eq('0025') }
        specify { expect(subject.extras).to be_blank }
      end
    end

    context 'when the record is invalid' do
      let!(:file_path) { 'spec/fixtures/nat_files/v8/NAT00060_invalid.txt' }
      specify { expect(subject).not_to be_blank }
    end
  end
end
