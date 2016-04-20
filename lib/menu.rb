class Menu
  OPTIONS = {
    1 => :create_contact,
    2 => :list_all_contacts,
    3 => :find_contact_by_first_name,
    4 => :exit_application
  }

  def find_contact(chosen_activity)
    chosen_activity == choose(:find_contact_by_first_name)
  end

  def list_contacts(chosen_activity)
    chosen_activity == choose(:list_all_contacts)
  end

  def create_contact(chosen_activity)
    chosen_activity == choose(:create_contact)
  end

  def choose(action)
    OPTIONS.key(action)
  end
end
