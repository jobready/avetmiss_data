class AvetmissData::Stores::V7::ClientPostalDetail < AvetmissData::Stores::V7::Base
  nat_file('NAT00085', {
    client_identifier: 0...10,
    client_title: 10...14,
    client_first_name: 14...54,
    client_last_name: 54...94,
    address_building: 94...144,
    address_unit: 144...174,
    address_street_number: 174...189,
    address_street_name: 189...259,
    address_po_box: 259...281,
    address_location: 281...331,
    address_postcode: 331...335,
    address_state_identifier: 335...337,
    telephone_home: 337...357,
    telephone_work: 357...377,
    telephone_mobile: 377...397,
    email_address: 397...477,
    extras: 477..-1
  })

  alias_method :identifier, :client_identifier
end
