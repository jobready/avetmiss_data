class AvetmissData::Stores::Course < AvetmissData::Stores::Base
  nat_file('NAT00030', {
    qualification_identifier: 0...10,
    qualification_name: 10...110,
    nominal_hours: 110...114,
    qualification_recognition_identifier: 114...116,
    qualification_education_level_identifier: 116...119,
    qualification_education_field_identifier: 119...123,
    anzsco_identifier: 123...129,
    vet_flag: 129...130,
    extras: 130..-1
  })
end
