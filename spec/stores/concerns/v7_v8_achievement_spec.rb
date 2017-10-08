require 'spec_helper'

describe AvetmissData::Stores::V7V8Achievement do
  let(:including_class) do
    Class.new(AvetmissData::Stores::Base) do
      include AvetmissData::Stores::V7V8Achievement
    end
  end

  context 'NAT File' do
    specify { expect(including_class.file_name).not_to be_blank }
    specify { expect(including_class.file_name).to eq('NAT00100') }
  end

  context 'NAT00100 record' do
    let!(:line) { File.open(file_path).first }
    subject { including_class.from_line(line) }

    context 'when the file is valid' do
      let(:file_path) { 'spec/fixtures/nat_files/v7/NAT00100.txt' }

      specify { expect(subject).not_to be_blank }
      specify { expect(subject.client_identifier).to eq('12345') }
      specify { expect(subject.prior_education_achievement_identifier).to eq('008') }
      specify { expect(subject.extras).to be_blank }
    end
  end
end
