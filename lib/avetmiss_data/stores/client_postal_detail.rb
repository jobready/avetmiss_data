class AvetmissData::Stores::ClientPostalDetail < AvetmissData::Stores::Base
  nat_file('NAT00085', {
    client_identifier: 0...10,
    client_title: 10...14,
    client_first_name: 14...54,
    client_last_name: 54...94,
    address_first_line: 94...144,
    address_second_line: 144...194,
    address_postal: 194...244,
    post_code: 244...248,
    state_identifier: 248...250,
    telephone_home: 250...270,
    telephone_work: 270...290,
    telephone_mobile: 290...310,
    email_address: 310...390,
    extras: 390..-1
  })
end
