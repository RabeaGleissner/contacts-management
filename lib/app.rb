require 'finder'
require 'creator'
require 'store'

class App
  attr_reader :contacts

  def initialize(ui, store, kernel = Kernel)
    @ui = ui
    @store = store
    @kernel = kernel
    @contacts = []
  end

  FIELDS = [:first_name, :last_name, :email_address, :mobile_number, :twitter_handle]
  MENU_OPTIONS = {
    1 => :create_contact,
    2 => :list_all_contacts,
    3 => :find_contact_by_first_name,
    4 => :exit_application
  }

  def run
    loop do
      menu
      break if user_quits?
    end
  end

  private

  attr_reader :ui, :store, :kernel

  def menu
    chosen_activity = users_response_to_menu
    if wish_to_create_contact(chosen_activity)
      Creator.new(ui, FIELDS, store).create_contact
    elsif wish_to_list_contacts(chosen_activity)
      ui.display_all(store.read_from_file)
    elsif find_contact(chosen_activity)
      display_found_contact
    else
      kernel.exit
    end
  end

  def find_contact(chosen_activity)
    chosen_activity == MENU_OPTIONS.key(:find_contact_by_first_name)
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
    Finder.new(ui, contacts).find_by(FIELDS.first)
  end

  def user_quits?
    !ui.continue?
  end
end
