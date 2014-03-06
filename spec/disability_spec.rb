require 'spec_helper'

describe AvetmissData::Disability do
  context 'imports the NAT00010 file' do

    context 'NAT File' do
      specify { expect(AvetmissData::Disability.file).not_to be_blank }
      specify { expect(AvetmissData::Disability.file).to eq('NAT00090') }
    end

    context 'NAT Record Parse' do
      let!(:row) { "12345     13" }
      subject { AvetmissData::Disability.parse(row) }

      specify { expect(subject).not_to be_blank }
      specify { expect(subject[:client_identifier]).to eq('12345') }
      specify { expect(subject[:disability_type_identifier]).to eq('13') }
      specify { expect(subject[:extras]).to be_blank }
    end
  end
end