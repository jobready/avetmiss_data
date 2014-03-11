FactoryGirl.define do
  trait :has_record_init do
    initialize_with { new(attributes.key?(:attributes) ? attributes.delete(:attributes) : {}) }
  end

  factory :store_base, class: 'AvetmissData::Stores::Base', traits: [:has_record_init]
  factory :store_rto, class: 'AvetmissData::Stores::Rto', traits: [:has_record_init]
  factory :store_rto_delivery_location, class: 'AvetmissData::Stores::RtoDeliveryLocation', traits: [:has_record_init]
  factory :store_course, class: 'AvetmissData::Stores::Course', traits: [:has_record_init]
  factory :store_unit_of_competency, class: 'AvetmissData::Stores::UnitOfCompetency', traits: [:has_record_init]
  factory :store_client, class: 'AvetmissData::Stores::Client', traits: [:has_record_init]
  factory :store_client_postal_detail, class: 'AvetmissData::Stores::ClientPostalDetail', traits: [:has_record_init]
  factory :store_disability, class: 'AvetmissData::Stores::Disability', traits: [:has_record_init]
  factory :store_achievement, class: 'AvetmissData::Stores::Achievement', traits: [:has_record_init]
  factory :store_enrolment, class: 'AvetmissData::Stores::Enrolment', traits: [:has_record_init]
  factory :store_qual_completion, class: 'AvetmissData::Stores::QualCompletion', traits: [:has_record_init]

end
