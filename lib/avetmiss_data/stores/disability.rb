class AvetmissData::Stores::Disability < AvetmissData::Stores::Base
  nat_file('NAT00090', {
    client_identifier: 0...10,
    disability_type_identifier: 10...12,
    extras: 12..-1
  })
end
