class MockStore
  attr_reader :contact

  def initialize
    @contact = nil
  end

  def persist(new_contact)
    @contact = new_contact
  end

  def read_from_file
  end
end
