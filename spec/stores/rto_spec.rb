require 'spec_helper'

describe AvetmissData::Stores::Rto do
  context 'imports the NAT00010 file' do

    context 'NAT File' do
      specify { expect(AvetmissData::Stores::Rto.file_name).not_to be_blank }
      specify { expect(AvetmissData::Stores::Rto.file_name).to eq('NAT00010') }
    end

    context 'NAT Record Parse' do
      let!(:line) { File.open('spec/fixtures/nat_files/NAT00010.txt').first }
      subject { AvetmissData::Stores::Rto.from_line(line) }

      specify { expect(subject).not_to be_blank }
      specify { expect(subject.training_organisation_identifier).to eq('01010') }
      specify { expect(subject.training_organisation_name).to eq('JobReady Solutions') }
      specify { expect(subject.training_organisation_type_identifier).to eq('91') }
      specify { expect(subject.address_first_line).to eq('Suite 203, 84 Alexander Street') }
      specify { expect(subject.address_second_line).to be_blank }
      specify { expect(subject.address_location).to eq('Crows Nest') }
      specify { expect(subject.post_code).to eq('2065') }
      specify { expect(subject.state_identifier).to eq('01') }
      specify { expect(subject.extras).not_to be_blank }
    end
  end
end
