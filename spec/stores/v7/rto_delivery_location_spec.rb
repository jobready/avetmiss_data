require 'spec_helper'

describe AvetmissData::Stores::V7::RtoDeliveryLocation do
  context 'imports the NAT00020 file' do

    context 'NAT File' do
      specify { expect(AvetmissData::Stores::V7::RtoDeliveryLocation.file_name).not_to be_blank }
      specify { expect(AvetmissData::Stores::V7::RtoDeliveryLocation.file_name).to eq('NAT00020') }
    end

    context 'NAT Record Parse' do
      let!(:line) { File.open('spec/fixtures/nat_files/v7/NAT00020.txt').first }
      subject { AvetmissData::Stores::V7::RtoDeliveryLocation.from_line(line) }

      specify { expect(subject.training_organisation_identifier).to eq('01010') }
      specify { expect(subject.training_organisation_delivery_location_identifier).to eq('4707') }
      specify { expect(subject.training_organisation_delivery_location_name).to eq('Park View Motor Inn-Wangaratta') }
      specify { expect(subject.post_code).to eq('3677') }
      specify { expect(subject.state_identifier).to eq('02') }
      specify { expect(subject.address_location).to eq('WANGARATTA') }
      specify { expect(subject.country_identifier).to eq('1101') }
      specify { expect(subject.extras).to be_blank }
    end
  end
end
