class AvetmissData::Stores::V7::Achievement < AvetmissData::Stores::V7::Base
  nat_file('NAT00100', {
    client_identifier: 0...10,
    prior_education_achievement_identifier: 10...13,
    extras: 13..-1
  })

  alias_method :identifier, :client_identifier
end
