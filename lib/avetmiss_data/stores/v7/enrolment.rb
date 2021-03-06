class AvetmissData::Stores::V7::Enrolment < AvetmissData::Stores::V7::Base
  nat_file('NAT00120', {
    delivery_location_identifier: 0...10,
    client_identifier: 10...20,
    unit_competency_identifier: 20...32,
    qualification_identifier: 32...42,
    enrolment_activity_start_date: 42...50,
    enrolment_activity_end_date: 50...58,
    delivery_mode_identifier: 58...60,
    national_outcome_identifier: 60...62,
    scheduled_hours: 62...66,
    national_funding_source: 66...68,
    commencing_course_identifier: 68...69,
    new_apprenticeships_training_contract_identifier: 69...79,
    new_apprenticeships_client_identifier: 79...89,
    study_reason_identifier: 89...91,
    vet_in_school_flag: 91...92,
    specific_funding_identifier: 92...102,
    training_organisation_outcome_identifier: 102...105,
    state_training_authority_funding_source: 105...108,
    client_tuition_fee: 108...112,
    exemption_type_identifier: 112...113,
    purchasing_contract_identifier: 113...125,
    purchasing_contract_schedule_identifier: 125...128,
    hours_attended: 128...132,
    associated_course_identifier: 132...142,
    extras: 142..-1
  })

  alias_method :identifier, :client_identifier
end
