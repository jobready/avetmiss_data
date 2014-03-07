require 'spec_helper'

describe AvetmissData::Stores::Base do
  context '#file_format_hash' do
    let(:store_base) { build :store_base }
    before { AvetmissData::Stores::Base.nat_file("", {}) }
    specify { expect(store_base.file_format).not_to be_nil }
  end

  context 'reading/writing' do
    before do
      AvetmissData::Stores::Base.nat_file("", {
        foo: 0...5,
        bar: 5...10,
        baz: 10..-1
      })
    end

    context '.parse' do
      specify do
        expect(AvetmissData::Stores::Base.parse('12345abcdeLOL')).to eq(
          foo: '12345',
          bar: 'abcde',
          baz: 'LOL'
        )
      end

      specify do
        expect(AvetmissData::Stores::Base.parse('1 3  ab   LOL')).to eq(
          foo: '1 3',
          bar: 'ab',
          baz: 'LOL'
        )
      end

      specify do
        expect(AvetmissData::Stores::Base.parse(' 23 5   deLOL')).to eq(
          foo: '23 5',
          bar: 'de',
          baz: 'LOL'
        )
      end

      specify do
        expect(AvetmissData::Stores::Base.parse('12345abcde')).to eq(
          foo: '12345',
          bar: 'abcde',
          baz: ''
        )
      end
    end

    context 'loading' do
      let!(:store_base) { build :store_base, record: '12345abcdeLOL' }
      specify do
        expect(store_base.foo).to eq('12345')
        expect(store_base.bar).to eq('abcde')
        expect(store_base.baz).to eq('LOL')
      end
    end

    context 'storing' do
      let!(:store_base) { build :store_base, record: '12345abcdeLOL' }
      specify { expect(store_base.to_record).to eq('12345abcdeLOL') }
    end

    context '.max_record' do
      specify { expect(AvetmissData::Stores::Base.max_record).to eq(10) }
    end

    context '.to_record' do
      specify do
        expect(AvetmissData::Stores::Base.to_record(
          foo: '12345',
          bar: 'abcde',
          baz: 'LOL'
        )).to eq('12345abcdeLOL')
      end

      specify do
        expect(AvetmissData::Stores::Base.to_record(
          foo: '12 3 ',
          bar: 'a  de',
          baz: 'L L'
        )).to eq('12 3 a  deL L')
      end

      specify do
        expect(AvetmissData::Stores::Base.to_record(
          foo: '  345',
          bar: '  c e',
          baz: ' OL'
        )).to eq('  345  c e OL')
      end

      specify do
        expect(AvetmissData::Stores::Base.to_record(
          foo: '12345',
          bar: 'abcde',
          baz: 'LOL',
          cool: 'bananas'
        )).to eq('12345abcdeLOL')
      end

      specify do
        expect(AvetmissData::Stores::Base.to_record(
          foo: '12345',
          baz: 'LOL'
        )).to eq('12345     LOL')
      end
    end
  end

end
