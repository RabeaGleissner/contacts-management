class FakeUi
  attr_reader :display_contacts_was_called

  def initialize(menu_option)
    @menu_option = menu_option
    @display_contacts_was_called = false
  end

  def menu(options)
    menu_option
  end

  def get_contact_details(field)
    {
     :first_name=>"Jon",
     :last_name=>"Doe",
     :email=>"jon@123.de",
     :mobile_number=>"00000",
     :twitter=>"@jon"
    }
  end

  def display_all_contacts(contacts)
    @display_contacts_was_called = true
  end

  private

  attr_reader :menu_option
end
