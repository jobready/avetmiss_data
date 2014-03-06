require 'spec_helper'

describe AvetmissData::UnitOfCompetency do
  context 'imports the NAT00060 file' do

    context 'NAT File' do
      specify { expect(AvetmissData::UnitOfCompetency.file).not_to be_blank }
      specify { expect(AvetmissData::UnitOfCompetency.file).to eq('NAT00060') }
    end

    context 'NAT Record Parse' do
      let!(:row) { File.open('spec/fixtures/nat_files/NAT00060.txt').first }
      subject { AvetmissData::UnitOfCompetency.parse(row) }

      specify { expect(subject).not_to be_blank }
      specify { expect(subject[:unit_competency_flag]).to eq('M') }
      specify { expect(subject[:unit_competency_identifier]).to eq('AE1') }
      specify { expect(subject[:unit_competency_name]).to eq('Academic English 1') }
      specify { expect(subject[:unit_competency_education_field_identifier]).to eq('000000') }
      specify { expect(subject[:vet_flag]).to eq('N') }
      specify { expect(subject[:nominal_hours]).to eq('0025') }
      specify { expect(subject[:extras]).to be_blank }
    end
  end
end
