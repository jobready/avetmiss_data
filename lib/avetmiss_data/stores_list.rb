class AvetmissData::StoresList < Set
  attr_accessor :package

  def initialize(package, enum = nil)
    @package = package
    super(enum)
  end

  def add(store)
    super(store)
    store.package = @package
    self
  end
  alias << add
end
