require 'spec_helper'

describe AvetmissData::Stores::V7::ClientPostalDetail do
  context 'imports the NAT00085 file' do

    context 'NAT File' do
      specify { expect(AvetmissData::Stores::V7::ClientPostalDetail.file_name).not_to be_blank }
      specify { expect(AvetmissData::Stores::V7::ClientPostalDetail.file_name).to eq('NAT00085') }
    end

    context 'NAT Record Parse' do
      let!(:line) { File.open('spec/fixtures/nat_files/v7/NAT00085.txt').first }
      subject { AvetmissData::Stores::V7::ClientPostalDetail.from_line(line) }

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
      specify { expect(subject.address_location).to eq('Santa Clara') }
      specify { expect(subject.address_postcode).to eq('2001') }
      specify { expect(subject.address_state_identifier).to eq('08') }
      specify { expect(subject.telephone_home).to eq('0212345678') }
      specify { expect(subject.telephone_work).to eq('0299125678') }
      specify { expect(subject.telephone_mobile).to eq('0400123456') }
      specify { expect(subject.email_address).to eq('ritar@jobready.com.au') }
      specify { expect(subject.extras).to be_blank }
    end
  end
end
