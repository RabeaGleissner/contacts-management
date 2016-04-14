class FakeUi
  attr_reader :display_contacts_was_called, :menu_calls_count

  def initialize(menu_options, continue_choice)
    @menu_options = menu_options
    @continue_choice = continue_choice
    @display_contacts_was_called = false
    @menu_calls_count = 0
  end

  def menu(options)
    @menu_calls_count += 1
    @menu_options.pop
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
    continue_choice.shift
  end

  private

  attr_reader :menu_option, :continue_choice
end
