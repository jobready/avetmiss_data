class AvetmissData::Stores::V8::Client < AvetmissData::Stores::V8::Base
  nat_file('NAT00080', {
    client_identifier: 0...10,
    name_for_encryption: 10...70,
    highest_school_level_completed: 70...72,
    gender: 72...73,
    date_of_birth: 73...81,
    address_postcode: 81...85,
    indigenous_status_identifier: 85...86,
    main_language_not_english: 86...90,
    labour_force_status_identifier: 90...92,
    country_identifier: 92...96,
    disability_flag: 96...97,
    prior_education_achievement_flag: 97...98,
    at_school_flag: 98...99,
    address_suburb_locality_or_town: 99...149,
    unique_student_identifier: 149...159,
    address_state_identifier: 159...161,
    address_building: 161...211,
    address_unit: 211...241,
    address_street_number: 241...256,
    address_street_name: 256...326,
    survey_contact_status: 326...327,
    extras: 327..-1
  })

  alias_method :identifier, :client_identifier
end
