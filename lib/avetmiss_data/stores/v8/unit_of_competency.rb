class AvetmissData::Stores::V8::UnitOfCompetency < AvetmissData::Stores::V8::Base
  nat_file('NAT00060', {
    unit_competency_identifier: 0...12,
    unit_competency_name: 12...112,
    unit_competency_education_field_identifier: 112...118,
    vet_flag: 118...119,
    nominal_hours: 119...123,
    extras: 123..-1
  })

  alias_method :identifier, :unit_competency_identifier
end
