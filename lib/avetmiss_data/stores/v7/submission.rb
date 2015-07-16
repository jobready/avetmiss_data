class AvetmissData::Stores::V7::Submission < AvetmissData::Stores::V7::Base
  nat_file('NAT00005', {
    training_authority_identifier: 0...10,
    training_authority_name: 10...110,
    address_first_line: 110...160,
    address_second_line: 160...210,
    address_location: 210...260,
    post_code: 260...264,
    state_identifier: 264...266,
    contact_name: 266...326,
    telephone_number: 326...346,
    fax_number: 346...366,
    email_address: 366...446,
    extras: 446..-1
  })

  alias_method :identifier, :training_authority_identifier
end
