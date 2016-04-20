class FakeUi
  attr_reader :displayed_all, :menu_calls_count, :get_search_keyword, :contact_details_to_display, :display_no_contact_error

  def initialize(chosen_actions = [2], continue_choice = [false], contact_details = [])
    @chosen_actions = chosen_actions
    @continue_choice = continue_choice
    @contact_details = contact_details
    @displayed_all = false
    @menu_calls_count = 0
    @get_search_keyword = false
    @contact_details_to_display = nil
    @search_keyword = nil
    @display_no_contact_error = false
  end

  def users_selected_action(options)
    @menu_calls_count += 1
    chosen_actions.pop
  end

  def details_for(field)
    contact_details.shift
  end

  def display_all(contacts)
    @displayed_all = true
    @contact_details_to_display = contacts
  end

  def continue?
    continue_choice.shift
  end

  def confirm_contact_creation
  end

  def ask_for_search_keyword(word)
    @get_search_keyword = true
    @search_keyword
  end

  def set_search_keyword(word)
    @search_keyword = word
  end

  def no_contacts_to_display_message
    @display_no_contact_error = true
  end

  private

  attr_reader :chosen_actions, :continue_choice, :contact_details
end
