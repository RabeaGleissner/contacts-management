require 'finder'

class App
  attr_reader :contacts

  def initialize(ui)
    @ui = ui
    @contacts = []
  end

  FIELDS = [:first_name, :last_name, :email_address, :mobile_number, :twitter_handle]
  MENU_OPTIONS = {
    1 => :create_contact,
    2 => :list_all_contacts,
    3 => :find_contact_by_first_name
  }

  def run
    loop do
      menu
      break if user_quits?
    end
  end

  private

  def menu
    chosen_activity = users_response_to_menu
    if wish_to_create_contact(chosen_activity)
      contacts << ui.get_contact_details(FIELDS)
    elsif wish_to_list_contacts(chosen_activity)
      ui.display_all(contacts)
    else
      display_found_contact
    end
  end

  def wish_to_list_contacts(chosen_activity)
    chosen_activity == MENU_OPTIONS.key(:list_all_contacts)
  end

  def wish_to_create_contact(chosen_activity)
    chosen_activity == MENU_OPTIONS.key(:create_contact)
  end

  def users_response_to_menu
    ui.display_menu(MENU_OPTIONS)
  end

  def display_found_contact
    contacts_found = Finder.new(ui, contacts).find_by(FIELDS.first)
    ui.display_all(contacts_found)
  end

  def user_quits?
    !ui.continue?
  end

  attr_reader :ui
end
