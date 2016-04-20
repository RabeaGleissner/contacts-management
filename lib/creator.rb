class Creator
  attr_reader :ui, :fields, :store

  def initialize(ui, fields, store)
    @ui = ui
    @fields = fields
    @store = store
    @contacts = []
  end

  def create_contact
    new_contact = {}
    fields.each do |field_name|
      new_contact[field_name] = ui.details_for(field_name)
    end
    ui.confirm_contact_creation
    store.persist(new_contact)
  end

  private

  attr_reader :contacts
end
