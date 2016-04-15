class FakeUi
  attr_reader :display_all_was_called, :menu_calls_count, :search_action_was_called

  def initialize(chosen_actions = [2], continue_choice = [false], contact_details = [])
    @chosen_actions = chosen_actions
    @continue_choice = continue_choice
    @contact_details = contact_details
    @display_all_was_called = false
    @menu_calls_count = 0
    @search_action_was_called = false
  end

  def display_menu(options)
    @menu_calls_count += 1
    chosen_actions.pop
  end

  def details_for(field)
    contact_details.shift
  end

  def display_all(contacts)
    @display_all_was_called = true
  end

  def continue?
    continue_choice.shift
  end

  def ask_for_search_keyword(word)
    @search_action_was_called = true
    "Jane"
  end

  private

  attr_reader :chosen_actions, :continue_choice, :contact_details
end
