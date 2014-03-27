class AvetmissData::Stores::V7::Client < AvetmissData::Stores::V7::Base
  nat_file('NAT00080', {
    client_identifier: 0...10,
    name_for_encryption: 10...70,
    highest_school_level_completed: 70...72,
    highest_school_level_completed_year: 72...76,
    sex: 76...77,
    date_of_birth: 77...85,
    address_postcode: 85...89,
    indigenous_status_identifier: 89...90,
    main_language_not_english: 90...94,
    labour_force_status_identifier: 94...96,
    country_identifier: 96...100,
    disability_flag: 100...101,
    prior_education_achievement_flag: 101...102,
    at_school_flag: 102...103,
    english_proficiency_identifier: 103...104,
    address_location: 104...154,
    unique_student_identifier: 154...164,
    address_state_identifier: 164...166,
    address_building: 166...216,
    address_unit: 216...246,
    address_street_number: 246...261,
    address_street_name: 261...331,
    extras: 331..-1
  })

  alias_method :identifier, :client_identifier
end
