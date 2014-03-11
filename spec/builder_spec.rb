require 'spec_helper'

describe AvetmissData::Builder do
  let!(:mapping) do
    {
      foo: 0...5,
      bar: 5...10,
      baz: 10..-1
    }
  end
  let!(:builder) { AvetmissData::Builder.new(mapping) }

  context '#max_line' do
    specify { expect(builder.max_line).to eq(10) }
  end

  context '#build' do
    specify do
      expect(builder.build(
        foo: '12345',
        bar: 'abcde',
        baz: 'LOL'
      )).to eq('12345abcdeLOL')
    end

    specify do
      expect(builder.build(
        foo: '12 3 ',
        bar: 'a  de',
        baz: 'L L'
      )).to eq('12 3 a  deL L')
    end

    specify do
      expect(builder.build(
        foo: '  345',
        bar: '  c e',
        baz: ' OL'
      )).to eq('  345  c e OL')
    end

    specify do
      expect(builder.build(
        foo: '12345',
        bar: 'abcde',
        baz: 'LOL',
        cool: 'bananas'
      )).to eq('12345abcdeLOL')
    end

    specify do
      expect(builder.build(
        foo: '12345',
        baz: 'LOL'
      )).to eq('12345     LOL')
    end
  end
end
