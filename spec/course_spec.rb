require 'spec_helper'

describe AvetmissData::Course do
  context 'imports the NAT00030 file' do

    context 'NAT File' do
      specify { expect(AvetmissData::Course.file).not_to be_blank }
      specify { expect(AvetmissData::Course.file).to eq('NAT00030') }
    end

    context 'NAT Record Parse' do
      let!(:row) { File.open('spec/fixtures/nat_files/NAT00030.txt').first }
      subject { AvetmissData::Course.parse(row) }

      specify { expect(subject).not_to be_blank }
      specify { expect(subject[:qualification_identifier]).to eq('UTE31206') }
      specify { expect(subject[:qualification_name]).to eq('Electrotechnology Fire Protection Control') }
      specify { expect(subject[:nominal_hours]).to eq('0420') }
      specify { expect(subject[:qualification_recognition_identifier]).to eq('11') }
      specify { expect(subject[:qualification_education_level_identifier]).to eq('514') }
      specify { expect(subject[:qualification_education_field_identifier]).to eq('0313') }
      specify { expect(subject[:anzsco_identifier]).to eq('341111') }
      specify { expect(subject[:vet_flag]).to eq('N') }
      specify { expect(subject[:extras]).to be_blank }
    end
  end
end
