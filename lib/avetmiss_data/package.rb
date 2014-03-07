class AvetmissData::Package
  attr_accessor :store_rtos
  attr_accessor :store_rto_delivery_locations
  attr_accessor :store_courses
  attr_accessor :store_unit_of_competencies
  attr_accessor :store_clients
  attr_accessor :store_client_postal_details
  attr_accessor :store_disablities
  attr_accessor :store_achievements
  attr_accessor :store_enrolments
  attr_accessor :store_qual_completions

  def initialize
    @store_rtos = []
    @store_rto_delivery_locations = []
    @store_courses = []
    @store_unit_of_competencies = []
    @store_clients = []
    @store_client_postal_details = []
    @store_disabilities = []
    @store_achievements = []
    @store_enrolments = []
    @store_qual_completions = []
  end
end
