class AvetmissData::RtoDeliveryLocation < AvetmissData::Base
  self.file = 'NAT00020'
  self.file_format = {
    training_organisation_identifier: 0...10,
    training_organisation_delivery_location_identifier: 10...20,
    training_organisation_delivery_location_name: 20...120,
    post_code: 120...124,
    state_identifier: 124...126,
    address_location: 126...176,
    country_identifier: 176...180,
    extras: 180..-1
  }
end
