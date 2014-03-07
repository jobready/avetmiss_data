class AvetmissData::Stores::Achievement < AvetmissData::Stores::Base
  nat_file('NAT00100', {
    client_identifier: 0...10,
    prior_education_achievement_identifier: 10...13,
    extras: 13..-1
  })
end
