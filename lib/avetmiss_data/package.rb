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
    self.rto_stores = []
    self.rto_delivery_location_stores = []
    self.course_stores = []
    self.unit_of_competency_stores = []
    self.client_stores = []
    self.client_postal_detail_stores = []
    self.disability_stores = []
    self.achievement_stores = []
    self.enrolment_stores = []
    self.qual_completion_stores = []
  end

  def rto_stores=(list)
    @rto_stores = initialize_stores_list(list)
  end

  def rto_delivery_location_stores=(list)
    @rto_delivery_location_stores = initialize_stores_list(list)
  end

  def course_stores=(list)
    @course_stores = initialize_stores_list(list)
  end

  def unit_of_competency_stores=(list)
    @unit_of_competency_stores = list
  end

  def client_stores=(list)
    @client_stores = initialize_stores_list(list)
  end

  def client_postal_detail_stores=(list)
    @client_postal_detail_stores = initialize_stores_list(list)
  end

  def disability_stores=(list)
    @disability_stores = initialize_stores_list(list)
  end

  def achievement_stores=(list)
    @achievement_stores = initialize_stores_list(list)
  end

  def enrolment_stores=(list)
    @enrolment_stores = initialize_stores_list(list)
  end

  def qual_completion_stores=(list)
    @qual_completion_stores = initialize_stores_list(list)
  end

  def store_list_for(store)
    store_name = store.class.name.demodulize.underscore
    send("#{store_name}_stores")
  end

  def from_zip_file(path)
    stores = AvetmissData::ZipFile.new(path).stores
    self.rto_stores = stores["NAT00010"]
    self.rto_delivery_location_stores = stores["NAT00020"]
    self.course_stores = stores["NAT00030"]
    self.unit_of_competency_stores = stores["NAT00060"]
    self.client_stores = stores["NAT00080"]
    self.client_postal_detail_stores = stores["NAT00085"]
    self.disability_stores = stores["NAT00090"]
    self.achievement_stores = stores["NAT00100"]
    self.enrolment_stores = stores["NAT00120"]
    self.qual_completion_stores = stores["NAT00130"]
    self
  end

  def each_store(&block)
    [rto_stores, rto_delivery_location_stores, course_stores, unit_of_competency_stores, client_stores,
     client_postal_detail_stores, disability_stores, achievement_stores, enrolment_stores,
     qual_completion_stores].each do |stores_list|
       stores_list.each(&block)
     end
  end

  private

  def initialize_stores_list(list)
    AvetmissData::StoresList.new(self, list)
  end
end
