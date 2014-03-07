require 'spec_helper'

describe AvetmissData::Stores::QualCompletion do
  context 'imports the NAT00130 file' do

    context 'NAT File' do
      specify { expect(AvetmissData::Stores::QualCompletion.file_name).not_to be_blank }
      specify { expect(AvetmissData::Stores::QualCompletion.file_name).to eq('NAT00130') }
    end

    context 'NAT Record Parse' do
      let!(:record) { File.open('spec/fixtures/nat_files/NAT00130.txt').first }
      subject { build :store_qual_completion, record: record }

      specify { expect(subject).not_to be_blank }
      specify { expect(subject.training_organisation_identifier).to eq('01010') }
      specify { expect(subject.qualification_identifier).to eq('UTE31206') }
      specify { expect(subject.client_identifier).to eq('12345') }
      specify { expect(subject.program_completed_year).to eq('2013') }
      specify { expect(subject.qualification_issued_flag).to eq('Y') }
      specify { expect(subject.extras).to be_blank }
    end
  end
end
