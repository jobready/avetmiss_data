class AvetmissData::Stores::V8::Enrolment < AvetmissData::Stores::V8::Base
  nat_file('NAT00120', {
    training_organisation_identifier: 0...10,
    delivery_location_identifier: 10...20,
    client_identifier: 20...30,
    unit_competency_identifier: 30...42,
    qualification_identifier: 42...52,
    enrolment_activity_start_date: 52...60,
    enrolment_activity_end_date: 60...68,
    delivery_mode_identifier: 68...71,
    national_outcome_identifier: 71...73,
    national_funding_source: 73...75,
    commencing_course_identifier: 75...76,
    new_apprenticeships_training_contract_identifier: 76...86,
    new_apprenticeships_client_identifier: 86...96,
    study_reason_identifier: 96...98,
    vet_in_school_flag: 98...99,
    specific_funding_identifier: 99...109,
    school_type_identifier: 109...111,
    training_organisation_outcome_identifier: 111...114,
    state_training_authority_funding_source: 114...117,
    client_tuition_fee: 117...122,
    exemption_type_identifier: 122...124,
    purchasing_contract_identifier: 124...136,
    purchasing_contract_schedule_identifier: 136...139,
    hours_attended: 139...143,
    associated_course_identifier: 143...153,
    scheduled_hours: 153...157,
    predominant_delivery_mode: 157...158,
    extras: 158..-1
  })

  alias_method :identifier, :client_identifier
end
