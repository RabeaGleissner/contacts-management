require 'finder'

class App
  attr_reader :contacts

  def initialize(ui)
    @ui = ui
    @contacts = []
  end

  FIELDS = [:first_name, :last_name, :email_address, :mobile_number, :twitter_handle]
  MENU_OPTIONS = {
    1 => "Create contact",
    2 => "List all contacts",
    3 => "Find contact by first name"
  }

  def run
    counter = 0
    loop do
      option = ui.menu(MENU_OPTIONS)
      if option == 1
        contacts << ui.get_contact_details(FIELDS)
      elsif option == 2
        ui.display_all(contacts)
      else
        display_found_contact
      end
      break if user_quits?
    end
  end


  private

  def display_found_contact
    contacts_found = Finder.new(ui, contacts).find_by(FIELDS.first)
    ui.display_all(contacts_found)
  end

  def user_quits?
    !ui.continue?
  end

  attr_reader :ui
end
