class AvetmissData::Stores::V7::QualCompletion < AvetmissData::Stores::V7::Base
  nat_file('NAT00130', {
    training_organisation_identifier: 0...10,
    qualification_identifier: 10...20,
    client_identifier: 20...30,
    program_completed_year: 30...34,
    qualification_issued_flag: 34...35,
    extras: 35..-1
  })

  alias_method :identifier, :client_identifier
end
