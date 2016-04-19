require 'clear_screen_printer'

class Ui
  attr_reader :input, :output

  def initialize(input, output)
    @input = input
    @output = output
    @printer = ClearScreenPrinter.new(output)
  end

  def display_menu(options)
    printer.print(" :::Contacts management::: \n\nPlease choose a menu option:\n\n")
    options.each do |number, option|
      output.puts "#{number} - #{format_for_display(option)}"
    end
    output.print"\n---> "
    get_menu_option(options)
  end

  def display_all(contacts)
    printer.print("")
    if contacts.length >= 1
      contacts.each { |contact| display(contact)}
    else
      output.puts "Sorry, there are no contacts to display!"
    end
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

  private

  attr_reader :printer

  def get_search_keyword(keyword)
    user_input = input.gets.chomp
    if user_input == ""
      printer.print("\nPlease provide the search keyword: ")
      ask_for_search_keyword(keyword)
    else
      user_input
    end
  end

  def get_data_for_field(field_name)
    user_input = input.gets.chomp
    if user_input == ""
      output.puts "#{CLEAR_SCREEN}\nEach field is required. Please enter the #{format_for_display(field_name).downcase}"
      details_for(field_name)
    else
      user_input
    end
  end

  def display(contact)
    contact.each do |field, entry|
      output.puts "#{format_for_display(field)}: #{entry}"
    end
    output.puts "---"
  end

  def get_continue_request
    decision = input.gets.chomp
    if decision == "y"
      true
    elsif decision == "n"
      false
    else
      continue?
    end
  end

  def get_menu_option(options)
    user_input = input.gets.chomp
    if valid_menu_option?(user_input, options)
      user_input.to_i
    else
      display_menu(options)
    end
  end

  def valid_menu_option?(user_input, options)
    options.key?(user_input.to_i)
  end

  def format_for_display(symbol)
    symbol.to_s.capitalize.split("_").join(" ")
  end
end
