class AvetmissData::Stores::V8::Rto < AvetmissData::Stores::V8::Base
  nat_file('NAT00010', {
    training_organisation_identifier: 0...10,
    training_organisation_name: 10...110,
    extras: 110..-1
  })

  alias_method :identifier, :training_organisation_identifier
end
