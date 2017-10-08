class AvetmissData::Stores::V8::QualCompletion < AvetmissData::Stores::V8::Base
  nat_file('NAT00130', {
    training_organisation_identifier: 0...10,
    qualification_identifier: 10...20,
    client_identifier: 20...30,
    program_completed_date: 30...38,
    qualification_issued_flag: 38...39,
    extras: 39..-1
  })

  alias_method :identifier, :client_identifier
end
