class FakeUi
  attr_reader :display_contacts_was_called, :count_menu_calls

  def initialize(menu_option)
    @menu_option = menu_option
    @display_contacts_was_called = false
    @count_menu_calls = 0
  end

  def menu(options)
    @count_menu_calls += 1
    menu_option.pop
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

  def display_all(contacts)
    @display_contacts_was_called = true
  end

  def continue?
    [true, false].pop
  end

  private

  attr_reader :menu_option
end
