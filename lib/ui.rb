require 'clear_screen_printer'

class Ui
  attr_reader :input, :output

  def initialize(input, output)
    @input = input
    @output = output
    @printer = ClearScreenPrinter.new(output)
  end

  def users_selected_action(options)
    printer.puts_on_clear_screen(" :::Contacts management::: \n\nPlease choose a menu option:\n\n")
    options.each do |number, option|
      output.puts "#{number} - #{format_for_display(option)}"
    end
    output.print"\n---> "
    get_menu_option(options)
  end

  def display_all(contacts)
    printer.clear_screen
    if contacts_exist?(contacts)
      contacts.each { |contact| display(contact)}
    else
      no_contacts_to_display_message
    end
  end

  def no_contacts_to_display_message
    printer.clear_screen
    output.puts "Sorry, there are no contacts to display!"
  end

  def continue?
    output.puts "\nWould you like to continue? (y\\n)"
    get_continue_request
  end

  def details_for(field_name)
    output.print "#{format_for_display(field_name)}: "
    get_data_for_field(field_name)
  end

  def ask_for_search_keyword(keyword)
    output.puts "\nEnter #{format_for_display(keyword).downcase}:"
    get_search_keyword(keyword)
  end

  def confirm_contact_creation
    output.puts "\n\nContact created!"
  end

  def interruption_message
    printer.puts_on_clear_screen("You interrupted the application. Byyye!\n\n")
  end

  private

  attr_reader :printer

  def contacts_exist?(contacts)
    contacts != false && contacts.length >= 1
  end

  def get_search_keyword(keyword)
    user_input = input.gets.chomp
    if user_input == ""
      printer.puts_on_clear_screen("\nPlease provide the search keyword: ")
      ask_for_search_keyword(keyword)
    else
      user_input
    end
  end

  def get_data_for_field(field_name)
    user_input = input.gets.chomp
    if no_user_input(user_input)
      printer.puts_on_clear_screen("\nEach field is required. Please enter the #{format_for_display(field_name).downcase}")
      details_for(field_name)
    else
      user_input
    end
  end

  def no_user_input(input)
    input == ""
  end

  def display(contact)
    contact.each do |field, entry|
      output.puts "#{format_for_display(field)}: #{entry}"
    end
    output.puts "---"
  end

  def get_continue_request
    decision = input.gets.chomp.downcase
    if decision == "y"
      true
    elsif decision == "n"
      false
    else
      wrong_input_error
      continue?
    end
  end

  def wrong_input_error
    printer.puts_on_clear_screen("Please provide a valid option.")
  end

  def get_menu_option(options)
    user_input = input.gets.chomp
    if valid_menu_option?(user_input, options)
      user_input.to_i
    else
      users_selected_action(options)
    end
  end

  def valid_menu_option?(user_input, options)
    options.key?(user_input.to_i)
  end

  def format_for_display(symbol)
    symbol.to_s.capitalize.split("_").join(" ")
  end
end
