require 'spec_helper'

describe AvetmissData::StoresList do
  let(:package) { AvetmissData::Package.new }
  let(:store) { AvetmissData::Stores::V7::Rto.new }

  context '#initialize' do
    context 'no enum' do
      let(:stores_list) { AvetmissData::StoresList.new(package) }
      specify { expect(stores_list.package).to eq(package) }
      specify { expect(stores_list.length).to eq(0) }
    end

    context 'with enum' do
      let(:stores_list) { AvetmissData::StoresList.new(package, [store]) }
      specify { expect(stores_list.package).to eq(package) }
      specify { expect(stores_list.length).to eq(1) }
    end
  end

  context 'setting package' do
    let(:stores_list) { AvetmissData::StoresList.new(package) }

    context 'add' do
      before { stores_list.add(store) }
      specify { expect(stores_list.first).to eq(store) }
      specify { expect(store.package).to eq(package) }
    end

    specify { expect(stores_list.add(store)).to eq(stores_list) }

    context '<<' do
      before { stores_list << store }
      specify { expect(stores_list.first).to eq(store) }
      specify { expect(store.package).to eq(package) }
    end

    specify { expect(stores_list << store).to eq(stores_list) }
  end

  context 'duplicates' do
    let(:stores_list) { AvetmissData::StoresList.new(package) }
    before do
      2.times { stores_list << store }
    end
    specify { expect(stores_list.length).to eq(1) }
  end
end
