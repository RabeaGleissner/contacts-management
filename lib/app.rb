require 'contact_creator'

class App
  attr_reader :contacts

  def initialize(ui)
    @ui = ui
    @contacts = []
  end

  FIELDS = [:first_name, :last_name, :email, :mobile_number, :twitter]
  MENU_OPTIONS = {
    1 => "Create contact",
    2 => "List all contacts"
  }

  def run
    option = ui.menu(MENU_OPTIONS)
    if option == 1
      contacts << ui.get_contact_details(FIELDS)
    else
      ui.display_all(contacts)
    end
  end

  private

  attr_reader :ui
end
