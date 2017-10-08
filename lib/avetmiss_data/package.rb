# This is the overall package.
class AvetmissData::Package
  FILES_MAP = {
    rto_stores: "NAT00010",
    rto_delivery_location_stores: "NAT00020",
    course_stores: "NAT00030",
    unit_of_competency_stores: "NAT00060",
    client_stores: "NAT00080",
    client_postal_detail_stores: "NAT00085",
    disability_stores: "NAT00090",
    achievement_stores: "NAT00100",
    enrolment_stores: "NAT00120",
    qual_completion_stores: "NAT00130"
  }

  AGGREGATE_FILES_MAP = {
    submission_stores: "NAT00005"
  }.merge(FILES_MAP)

  attr_accessor :activity_year
  attr_accessor :organisation_code
  attr_accessor :submission_stores
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

  def initialize(attributes = {})
    self.attributes = attributes
    self.submission_stores = []
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

  def attributes=(attributes)
    attributes.each_pair do |attr, value|
      send("#{attr}=", value)
    end
  end

  def submission_stores=(list)
    @submission_stores = initialize_stores_list(list)
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
    @unit_of_competency_stores = initialize_stores_list(list)
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

  def [](attr)
    send(attr)
  end

  def []=(attr, value)
    send("#{attr}=", value)
  end

  def self.from_zip_file(zip_file, attributes={})
    stores = zip_file.stores
    package = AvetmissData::Package.new(attributes)
    package.submission_stores = stores["NAT00005"]
    package.rto_stores = stores["NAT00010"]
    package.rto_delivery_location_stores = stores["NAT00020"]
    package.course_stores = stores["NAT00030"] || stores["NAT00030A"]
    package.unit_of_competency_stores = stores["NAT00060"]
    package.client_stores = stores["NAT00080"]
    package.client_postal_detail_stores = stores["NAT00085"]
    package.disability_stores = stores["NAT00090"]
    package.achievement_stores = stores["NAT00100"]
    package.enrolment_stores = stores["NAT00120"]
    package.qual_completion_stores = stores["NAT00130"]
    package
  end

  def to_zip_file
    generate_zip_file(FILES_MAP)
  end

  def to_aggregate_zip_file
    generate_zip_file(AGGREGATE_FILES_MAP)
  end

  def each_store(&block)
    [submission_stores, rto_stores, rto_delivery_location_stores, course_stores, unit_of_competency_stores, client_stores,
     client_postal_detail_stores, disability_stores, achievement_stores, enrolment_stores,
     qual_completion_stores].each do |stores_list|
       stores_list.each(&block)
     end
  end

  private

  def initialize_stores_list(list)
    AvetmissData::StoresList.new(self, list)
  end

  def generate_zip_file(files_list)
    Zip::Archive.open_buffer(Zip::CREATE) do |archive|
      files_list.each_pair do |stores_name, file_name|
        lines = send(stores_name).map { |store| store.to_line }.join("\n")
        archive.add_buffer("#{file_name}.txt", lines)
      end
    end
  end
end
