require 'spec_helper'
require_relative '../../support/store_examples'

describe AvetmissData::Stores::V8::RtoDeliveryLocation do
  context 'NAT File' do
    specify { expect(described_class.file_name).not_to be_blank }
    specify { expect(described_class.file_name).to eq('NAT00020') }
  end

  context 'NAT00020 record' do
    let!(:line) { File.open(file_path).first }
    subject { described_class.from_line(line) }

    context 'when the record is valid' do

      context 'and contains no extra fields' do
        let(:file_path) { 'spec/fixtures/nat_files/v8/NAT00020.txt' }
        specify { expect(subject.training_organisation_identifier).to eq('01010') }
        specify { expect(subject.training_organisation_delivery_location_identifier).to eq('4707') }
        specify { expect(subject.training_organisation_delivery_location_name).to eq('Park View Motor Inn-Wangaratta') }
        specify { expect(subject.post_code).to eq('3677') }
        specify { expect(subject.state_identifier).to eq('02') }
        specify { expect(subject.address_location).to eq('WANGARATTA') }
        specify { expect(subject.country_identifier).to eq('1101') }
        specify { expect(subject.extras).to be_blank }
      end

      context 'and contains extra fields' do
        let(:file_path) { 'spec/fixtures/nat_files/v8/NAT00020_extrafields.txt' }
        specify { expect(subject.extras).to eq('extra data that we ignore') }
      end
    end

    it_behaves_like :store_processing_invalid_file
  end
end
