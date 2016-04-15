class FakeUi
  attr_reader :display_all_was_called, :menu_calls_count, :search_action_was_called

  def initialize(chosen_actions, continue_choice)
    @chosen_actions = chosen_actions
    @continue_choice = continue_choice
    @display_all_was_called = false
    @menu_calls_count = 0
    @search_action_was_called = false
  end

  def menu(options)
    @menu_calls_count += 1
    chosen_actions.pop
  end

  def get_contact_details(field)
    {
     :first_name=>"Jon",
     :last_name=>"Doe",
     :email=>"jon@123.de",
     :mobile_number=>"00000",
     :twitter=>"@jon"
    }
  end

  def display_all(contacts)
    @display_all_was_called = true
  end

  def continue?
    continue_choice.shift
  end

  def ask_for_search_keyword(word)
    @search_action_was_called = true
  end

  private

  attr_reader :chosen_actions, :continue_choice
end
