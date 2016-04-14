require 'contact_creator'

class App
  attr_reader :ui

  def initialize(ui)
    @ui = ui
  end

  FIELDS = [:first_name, :last_name, :email, :mobile_number, :twitter]

  def run
    option = ui.menu
    if option == 1
      ui.get_contact_details(FIELDS)
    end
  end
end
