require 'spec_helper'

describe AvetmissData::Stores::V6::ClientPostalDetail do
  context 'imports the NAT00085 file' do

    context 'NAT File' do
      specify { expect(AvetmissData::Stores::V6::ClientPostalDetail.file_name).not_to be_blank }
      specify { expect(AvetmissData::Stores::V6::ClientPostalDetail.file_name).to eq('NAT00085') }
    end

    context 'NAT Record Parse' do
      let!(:line) { File.open('spec/fixtures/nat_files/v6/NAT00085.txt').first }
      subject { AvetmissData::Stores::V6::ClientPostalDetail.from_line(line) }

      specify { expect(subject).not_to be_blank }
      specify { expect(subject.client_identifier).to eq('12345') }
      specify { expect(subject.client_title).to eq('Mr') }
      specify { expect(subject.client_first_name).to eq('Mount') }
      specify { expect(subject.client_last_name).to eq('Franklin') }
      specify { expect(subject.address_first_line).to eq('Some Steet') }
      specify { expect(subject.address_second_line).to be_blank }
      specify { expect(subject.address_postal).to eq('Aarons Pass') }
      specify { expect(subject.post_code).to eq('2850') }
      specify { expect(subject.state_identifier).to eq('01') }
      specify { expect(subject.telephone_home).to eq('0312121231') }
      specify { expect(subject.telephone_work).to be_blank }
      specify { expect(subject.telephone_mobile).to eq('0222222222') }
      specify { expect(subject.email_address).to eq('ritar@jobready.com.au') }
      specify { expect(subject.extras).to be_blank }
    end
  end
end
