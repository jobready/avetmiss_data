require 'spec_helper'

describe AvetmissData::Stores::V7::Submission do
  context 'imports the NAT00005 file' do

    context 'NAT File' do
      specify { expect(AvetmissData::Stores::V7::Submission.file_name).not_to be_blank }
      specify { expect(AvetmissData::Stores::V7::Submission.file_name).to eq('NAT00005') }
    end

    context 'NAT Record Parse' do
      let!(:line) { File.open('spec/fixtures/nat_files/v7/NAT00005.txt').first }
      subject { AvetmissData::Stores::V7::Submission.from_line(line) }

      specify { expect(subject).not_to be_blank }
      specify { expect(subject.training_authority_identifier).to eq('0123456789') }
      specify { expect(subject.training_authority_name).to eq('Example Statutory Training Authority') }
      specify { expect(subject.address_first_line).to eq('GPO Box 100') }
      specify { expect(subject.address_second_line).to be_blank }
      specify { expect(subject.address_location).to eq('Canberra') }
      specify { expect(subject.post_code).to eq('2601') }
      specify { expect(subject.state_identifier).to eq('08') }
      specify { expect(subject.contact_name).to eq('Alice Smith') }
      specify { expect(subject.telephone_number).to eq('02 6000 1111') }
      specify { expect(subject.fax_number).to eq('02 6111 0000') }
      specify { expect(subject.email_address).to eq('alice.smith@example.com') }
      specify { expect(subject.extras).to be_blank }
    end
  end
end
