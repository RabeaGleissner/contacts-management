class StoreSpy
  attr_reader :persisted_data, :contact

  def initialize(persisted_data = nil)
    @persisted_data = persisted_data
    @contact = nil
  end

  def persist(new_contact)
    @contact = new_contact
  end

  def read_from_file
    @persisted_data
  end
end
