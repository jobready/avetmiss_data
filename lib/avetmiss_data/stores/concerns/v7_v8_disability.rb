module AvetmissData::Stores::V7V8Disability
  extend ActiveSupport::Concern
  included do
    nat_file('NAT00090', {
      client_identifier: 0...10,
      disability_type_identifier: 10...12,
      extras: 12..-1
      })

      alias_method :identifier, :client_identifier
  end
end
