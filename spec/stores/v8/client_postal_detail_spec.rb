require 'spec_helper'
require_relative '../../support/store_examples'

describe AvetmissData::Stores::V8::ClientPostalDetail do
  describe 'NAT File' do
    specify { expect(described_class.file_name).not_to be_blank }
    specify { expect(described_class.file_name).to eq('NAT00085') }
  end

  context 'v8 NAT00085 record' do
    let!(:line) { File.open(file_path).first }
    subject { described_class.from_line(line) }

    context 'when the record is valid' do
      context 'and has no extra fields' do
        let(:file_path) { 'spec/fixtures/nat_files/v8/NAT00085.txt' }

        specify { expect(subject).not_to be_blank }
        specify { expect(subject.client_identifier).to eq('12345') }
        specify { expect(subject.client_title).to eq('Mr') }
        specify { expect(subject.client_first_name).to eq('Mount') }
        specify { expect(subject.client_last_name).to eq('Franklin') }
        specify { expect(subject.address_building).to eq('Headquarters') }
        specify { expect(subject.address_unit).to eq('1') }
        specify { expect(subject.address_street_number).to eq('2200') }
        specify { expect(subject.address_street_name).to eq('Mission College Blvd') }
        specify { expect(subject.address_po_box).to eq('BOX 1') }
        specify { expect(subject.address_suburb_locality_or_town).to eq('Santa Clara') }
        specify { expect(subject.address_postcode).to eq('2001') }
        specify { expect(subject.address_state_identifier).to eq('08') }
        specify { expect(subject.telephone_home).to eq('0212345678') }
        specify { expect(subject.telephone_work).to eq('0299125678') }
        specify { expect(subject.telephone_mobile).to eq('0400123456') }
        specify { expect(subject.email_address).to eq('ritar@jobready.com.au') }
        specify { expect(subject.email_address_alternative).to eq('ritar02@jobready.com.au') }
        specify { expect(subject.extras).to be_blank }
      end

      context 'and has extra fields' do
        let(:file_path) { 'spec/fixtures/nat_files/v8/NAT00085_extrafields.txt' }
        specify { expect(subject.extras).to eq('extra data that we ignore') }
      end
    end

    it_behaves_like :store_processing_invalid_file
  end
end
