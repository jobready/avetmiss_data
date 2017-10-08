require 'spec_helper'

describe AvetmissData::Stores::V7V8RtoDeliveryLocation do
  let(:including_class) do
    Class.new(AvetmissData::Stores::Base) do
      include AvetmissData::Stores::V7V8RtoDeliveryLocation
    end
  end

  context 'NAT File' do
    specify { expect(including_class.file_name).not_to be_blank }
    specify { expect(including_class.file_name).to eq('NAT00020') }
  end

  context 'imports the NAT00020 file' do
    context 'NAT Record Parse' do
      let!(:line) { File.open('spec/fixtures/nat_files/v7/NAT00020.txt').first }
      subject { including_class.from_line(line) }

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
