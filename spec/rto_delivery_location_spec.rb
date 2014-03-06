require 'spec_helper'

describe AvetmissData::RtoDeliveryLocation do
  context 'imports the NAT00020 file' do

    context 'NAT File' do
      specify { expect(AvetmissData::RtoDeliveryLocation.file).not_to be_blank }
      specify { expect(AvetmissData::RtoDeliveryLocation.file).to eq('NAT00020') }
    end

    context 'NAT Record Parse' do
      let!(:row) { File.open('spec/fixtures/nat_files/NAT00020.txt').first }
      subject { AvetmissData::RtoDeliveryLocation.parse(row) }

      specify { expect(subject[:training_organisation_identifier]).to eq('01010') }
      specify { expect(subject[:training_organisation_delivery_location_identifier]).to eq('4707') }
      specify { expect(subject[:training_organisation_delivery_location_name]).to eq('Park View Motor Inn-Wangaratta') }
      specify { expect(subject[:post_code]).to eq('3677') }
      specify { expect(subject[:state_identifier]).to eq('02') }
      specify { expect(subject[:address_location]).to eq('WANGARATTA') }
      specify { expect(subject[:country_identifier]).to eq('1101') }
      specify { expect(subject[:extras]).to be_blank }
    end
  end
end
