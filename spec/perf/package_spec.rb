require 'spec_helper'

require 'benchmark'

describe 'Large package performance' do
  context 'load' do
    let(:zip_file) { AvetmissData::ZipFile.new('spec/fixtures/zip_files/large.zip') }

    specify do
      expect(Benchmark.realtime { zip_file }).to be < 0.4
      expect(zip_file.stores["NAT00120"].length).to eq(5152)
      expect(zip_file.stores["NAT00060"].length).to eq(14)
    end
  end
end
