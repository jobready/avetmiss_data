require 'spec_helper'

describe AvetmissData::Stores::Base do
  context '.nat_file' do
    let(:store_base) { AvetmissData::Stores::Base.new }
    before { AvetmissData::Stores::Base.nat_file('TEST', {}) }
    specify { expect(store_base.file_name).to eq('TEST') }
  end

  context 'reading/writing' do
    before do
      AvetmissData::Stores::Base.nat_file("", {
        foo: 0...5,
        bar: 5...10,
        baz: 10..-1
      })
    end

    let!(:attrs_set) do
      {
        foo: '12345',
        bar: 'abcde',
        baz: 'LOL'
      }
    end

    context '#attributes' do
      let!(:store_base) { AvetmissData::Stores::Base.new(attrs_set) }
      specify do
        expect(store_base.attributes).to eq(
          foo: '12345',
          bar: 'abcde',
          baz: 'LOL'
        )
      end
    end

    context 'sets attributes' do
      context 'attributes=' do
        let!(:store_base) { AvetmissData::Stores::Base.new }
        before { store_base.attributes = attrs_set }
        specify do
          expect(store_base.foo).to eq('12345')
          expect(store_base.bar).to eq('abcde')
          expect(store_base.baz).to eq('LOL')
        end
      end

      context 'on init' do
        let!(:store_base) { AvetmissData::Stores::Base.new(attrs_set) }
        specify do
          expect(store_base.foo).to eq('12345')
          expect(store_base.bar).to eq('abcde')
          expect(store_base.baz).to eq('LOL')
        end
      end
    end

    context '.from_line' do
      let!(:store_base) { AvetmissData::Stores::Base.from_line('12345abcdeLOL') }
      specify do
        expect(store_base.foo).to eq('12345')
        expect(store_base.bar).to eq('abcde')
        expect(store_base.baz).to eq('LOL')
      end
    end

    context 'storing' do
      let!(:store_base) { AvetmissData::Stores::Base.new(attrs_set) }
      specify { expect(store_base.to_line).to eq('12345abcdeLOL') }
    end
  end
end
