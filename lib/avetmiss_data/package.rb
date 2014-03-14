# This is the overall package.
class AvetmissData::Package
  attr_accessor :rto_stores
  attr_accessor :rto_delivery_location_stores
  attr_accessor :course_stores
  attr_accessor :unit_of_competency_stores
  attr_accessor :client_stores
  attr_accessor :client_postal_detail_stores
  attr_accessor :disability_stores
  attr_accessor :achievement_stores
  attr_accessor :enrolment_stores
  attr_accessor :qual_completion_stores

  def initialize
    @rto_stores = []
    @rto_delivery_location_stores = []
    @course_stores = []
    @unit_of_competency_stores = []
    @client_stores = []
    @client_postal_detail_stores = []
    @disability_stores = []
    @achievement_stores = []
    @enrolment_stores = []
    @qual_completion_stores = []
  end

  def from_zip_file(path)
    stores = AvetmissData::ZipFile.new(path, self).stores
    @rto_stores = stores["NAT00010"]
    @rto_delivery_location_stores = stores["NAT00020"]
    @course_stores = stores["NAT00030"]
    @unit_of_competency_stores = stores["NAT00060"]
    @client_stores = stores["NAT00080"]
    @client_postal_detail_stores = stores["NAT00085"]
    @disability_stores = stores["NAT00090"]
    @achievement_stores = stores["NAT00100"]
    @enrolment_stores = stores["NAT00120"]
    @qual_completion_stores = stores["NAT00130"]
  end

end
