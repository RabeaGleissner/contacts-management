require 'contact_creator'

class App
  attr_reader :contacts

  def initialize(ui)
    @ui = ui
    @contacts = [{:first_name=>"Jon", :last_name=>"Doe", :email=>"jon@123.de", :mobile_number=>"00000", :twitter=>"@jon"}]
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
