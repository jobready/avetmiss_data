require 'spec_helper'

describe AvetmissData::Errors::UnknownVersionError do
  describe 'message' do
    let(:error) { AvetmissData::Errors::UnknownVersionError.new(:v1) }
    subject { error.message }

    specify { expect(subject).to eq('Unknown NAT Version: v1') }
  end
end
