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
    counter = 0
    loop do
      option = ui.menu(MENU_OPTIONS)
      if option == 1
        contacts << ui.get_contact_details(FIELDS)
      else
        ui.display_all(contacts)
      end
      break if user_quits?
    end
  end

  private

  def user_quits?
    !ui.continue?
  end

  attr_reader :ui
end
