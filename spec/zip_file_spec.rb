require 'spec_helper'

describe AvetmissData::ZipFile do
  context 'read a zip file' do
    let!(:zip_file) { AvetmissData::ZipFile.new('spec/fixtures/zip_files/v7/valid.zip', '7.0') }

    context do
      specify { expect(zip_file.stores).not_to be_empty }
      let(:nat_10s) { zip_file.stores["NAT00010"] }
      specify { expect(nat_10s).not_to be_empty }
      specify { expect(nat_10s.length).to eq(1) }
      let(:nat_10) { nat_10s.first }
      specify { expect(nat_10.training_organisation_identifier).to eq('0101') }
    end
  end

  context 'read a zip file with mixed case filenames' do
    let!(:zip_file) { AvetmissData::ZipFile.new('spec/fixtures/zip_files/v7/valid_mixed_case.zip', '7.0') }

    context do
      specify { expect(zip_file.stores).not_to be_empty }
      let(:nat_10s) { zip_file.stores["NAT00010"] }
      specify { expect(nat_10s).not_to be_empty }
    end
  end

  context '#store_name_for' do
    let(:zip_file) { AvetmissData::ZipFile.new('') }
    specify { expect(zip_file.store_name_for("NAT00010.txt")).to eq("NAT00010") }
    specify { expect(zip_file.store_name_for("nat00010.txt")).to eq("NAT00010") }
    specify { expect(zip_file.store_name_for("NAT00010.TXT")).to eq("NAT00010") }
    specify { expect(zip_file.store_name_for("NaT00010.tXT")).to eq("NAT00010") }
  end
end
