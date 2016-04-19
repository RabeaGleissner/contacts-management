class Creator
  attr_reader :ui, :store
  FIELDS = [:first_name, :last_name, :email_address, :mobile_number, :twitter_handle]

  def initialize(ui, store)
    @ui = ui
    @store = store
    @contacts = []
  end

  def create_contact
    new_contact = {}
    FIELDS.each do |field_name|
      new_contact[field_name] = ui.details_for(field_name)
    end
    ui.confirm_contact_creation
    store.persist(new_contact)
  end

  private

  attr_reader :contacts
end
