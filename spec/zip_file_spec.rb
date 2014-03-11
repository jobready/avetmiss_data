require 'spec_helper'

describe AvetmissData::ZipFile do
  context 'read a zip file' do
    let!(:zip_file) { AvetmissData::ZipFile.new('spec/fixtures/zip_files/valid.zip') }

    context do
      specify { expect(zip_file.stores).not_to be_empty }
      let(:nat_10s) { zip_file.stores["NAT00010"] }
      specify { expect(nat_10s).not_to be_empty }
      specify { expect(nat_10s.length).to eq(1) }
      let(:nat_10) { nat_10s.first }
      specify { expect(nat_10.training_organisation_identifier).to eq('0101') }

    end
  end
end
