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

  context 'package_activity_year' do
    subject { store.package_activity_year }

    let(:store) { AvetmissData::Stores::V8::Enrolment.new(package: package) }

    context 'where activity_year present on package' do
      let(:package) { AvetmissData::Package.new(activity_year: 2015) }
      it { should eq(2015) }
    end

    context 'where activity_year blank on package' do
      let(:package) { AvetmissData::Package.new(activity_year: nil) }
      it { should be_nil }
    end

    context 'where package does not exist' do
      let(:store) { AvetmissData::Stores::V8::Enrolment.new }   # can't explicitly pass in package: nil
      it { should be_nil }
    end
  end

  context 'package_organisation_code' do
    subject { store.package_organisation_code }

    let(:store) { AvetmissData::Stores::V8::Enrolment.new(package: package) }

    context 'where organisation_code present on package' do
      let(:package) { AvetmissData::Package.new(organisation_code: 2015) }
      it { should eq(2015) }
    end

    context 'where organisation_code blank on package' do
      let(:package) { AvetmissData::Package.new(organisation_code: nil) }
      it { should be_nil }
    end

    context 'where package does not exist' do
      let(:store) { AvetmissData::Stores::V8::Enrolment.new }   # can't explicitly pass in package: nil
      it { should be_nil }
    end
  end

  context '#package=' do
    let(:enrolment_store) { AvetmissData::Stores::V7::Enrolment.new }
    let(:package) { AvetmissData::Package.new }

    context 'close the loop' do
      before { enrolment_store.package = package }
      specify { expect(package.enrolment_stores).to include(enrolment_store) }
    end

    specify { expect(enrolment_store.package = package).to eq(package) }
  end

  context 'store finders' do
    let(:package) { AvetmissData::Package.new }
    let(:rto_store) { AvetmissData::Stores::V7::Rto.new(training_organisation_identifier: '1') }
    let(:rto_delivery_location_store) {
      AvetmissData::Stores::V7::RtoDeliveryLocation.new(training_organisation_identifier: '1') }
    let(:rto_delivery_location_store2) {
      AvetmissData::Stores::V7::RtoDeliveryLocation.new(training_organisation_identifier: '2') }

    before do
      rto_store.package = package
      rto_delivery_location_store.package = package
      rto_delivery_location_store2.package = package
    end

    specify { expect(rto_delivery_location_store.rto_store_exists?).to be_truthy }
    specify { expect(rto_delivery_location_store.rto_store).to eq(rto_store) }
    specify { expect(rto_store.rto_store).to eq(rto_store) }
    specify { expect(rto_delivery_location_store.rto_delivery_location_store).to eq(rto_delivery_location_store) }
    specify { expect(rto_delivery_location_store2.rto_store_exists?).to be_falsey }
    specify { expect(rto_delivery_location_store2.rto_store).to be_nil }
    specify { expect(rto_delivery_location_store2.rto_delivery_location_store).to eq(rto_delivery_location_store2) }

  end

  context '.store_name' do
    let(:klass) { AvetmissData::Stores::V7::Enrolment }
    specify { expect(klass.store_name).to eq('enrolment') }
  end

  context '#store_name' do
    let(:enrolment_store) { AvetmissData::Stores::V7::Enrolment.new }
    specify { expect(enrolment_store.store_name).to eq('enrolment') }
  end

  context '#[]' do
    let(:enrolment_store) { AvetmissData::Stores::V7::Enrolment.new(delivery_location_identifier: '1234') }
    specify { expect(enrolment_store[:delivery_location_identifier]).to eq('1234') }
  end

  context '#[]=' do
    let(:enrolment_store) { AvetmissData::Stores::V7::Enrolment.new }
    before { enrolment_store[:delivery_location_identifier] = '1234' }
    specify { expect(enrolment_store.delivery_location_identifier).to eq('1234') }
  end
end
