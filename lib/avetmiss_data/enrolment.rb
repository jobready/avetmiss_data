class AvetmissData::Enrolment < AvetmissData::Base
  self.file = 'NAT00120'
  self.file_format = {
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
    training_organisation_outcome_identifier: 92...96,
    state_training_authority_funding_source: 96...99,
    extras: 99..-1
  }
end
