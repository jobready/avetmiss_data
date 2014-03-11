require 'spec_helper'

describe AvetmissData::Parser do
  let!(:mapping) do
    {
      foo: 0...5,
      bar: 5...10,
      baz: 10..-1
    }
  end
  let!(:parser) { AvetmissData::Parser.new(mapping) }

  context '.parse' do
    specify do
      expect(parser.parse('12345abcdeLOL')).to eq(
        foo: '12345',
        bar: 'abcde',
        baz: 'LOL'
      )
    end

    specify do
      expect(parser.parse('1 3  ab   LOL')).to eq(
        foo: '1 3',
        bar: 'ab',
        baz: 'LOL'
      )
    end

    specify do
      expect(parser.parse(' 23 5   deLOL')).to eq(
        foo: '23 5',
        bar: 'de',
        baz: 'LOL'
      )
    end

    specify do
      expect(parser.parse('12345abcde')).to eq(
        foo: '12345',
        bar: 'abcde',
        baz: ''
      )
    end
  end
end
