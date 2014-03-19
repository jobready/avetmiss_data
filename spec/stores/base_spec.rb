require 'spec_helper'

describe AvetmissData::Stores::Base do
  context '.nat_file' do
    let(:base_store) { AvetmissData::Stores::Base.new }
    before { AvetmissData::Stores::Base.nat_file('TEST', {}) }
    specify { expect(base_store.file_name).to eq('TEST') }
  end

  context 'reading/writing' do
    before do
      AvetmissData::Stores::Base.nat_file("", {
        foo: 0...5,
        bar: 5...10,
        baz: 10..-1
      })
    end

    let(:attrs_set) do
      {
        foo: '12345',
        bar: 'abcde',
        baz: 'LOL'
      }
    end

    context '#attributes' do
      let(:base_store) { AvetmissData::Stores::Base.new(attrs_set) }
      specify do
        expect(base_store.attributes).to eq(
          foo: '12345',
          bar: 'abcde',
          baz: 'LOL'
        )
      end
    end

    context 'sets attributes' do
      context 'attributes=' do
        let(:base_store) { AvetmissData::Stores::Base.new }
        before { base_store.attributes = attrs_set }
        specify do
          expect(base_store.foo).to eq('12345')
          expect(base_store.bar).to eq('abcde')
          expect(base_store.baz).to eq('LOL')
        end
      end

      context 'on init' do
        let(:base_store) { AvetmissData::Stores::Base.new(attrs_set) }
        specify do
          expect(base_store.foo).to eq('12345')
          expect(base_store.bar).to eq('abcde')
          expect(base_store.baz).to eq('LOL')
        end
      end
    end

    context '.from_line' do
      let(:base_store) { AvetmissData::Stores::Base.from_line('12345abcdeLOL') }
      specify do
        expect(base_store.foo).to eq('12345')
        expect(base_store.bar).to eq('abcde')
        expect(base_store.baz).to eq('LOL')
      end
    end

    context 'storing' do
      let(:base_store) { AvetmissData::Stores::Base.new(attrs_set) }
      specify { expect(base_store.to_line).to eq('12345abcdeLOL') }
    end
  end

  context '#package=' do
    let(:enrolment_store) { AvetmissData::Stores::Enrolment.new }
    let(:package) { AvetmissData::Package.new }

    context 'close the loop' do
      before { enrolment_store.package = package }
      specify { expect(package.enrolment_stores).to include(enrolment_store) }
    end

    specify { expect(enrolment_store.package = package).to eq(package) }
  end

  context 'store finders' do
    let(:package) { AvetmissData::Package.new }
    let(:rto_store) { AvetmissData::Stores::Rto.new(training_organisation_identifier: '1') }
    let(:rto_delivery_location_store) {
      AvetmissData::Stores::RtoDeliveryLocation.new(training_organisation_identifier: '1') }
    let(:rto_delivery_location_store2) {
      AvetmissData::Stores::RtoDeliveryLocation.new(training_organisation_identifier: '2') }

    before do
      rto_store.package = package
      rto_delivery_location_store.package = package
      rto_delivery_location_store2.package = package
    end

    specify { expect(rto_delivery_location_store.rto_store_exists?).to be_true }
    specify { expect(rto_delivery_location_store.rto_store).to eq(rto_store) }
    specify { expect(rto_delivery_location_store2.rto_store_exists?).to be_false }
    specify { expect(rto_delivery_location_store2.rto_store).to be_nil }
  end

end
