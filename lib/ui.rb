class Ui
  attr_reader :input, :output

  CLEAR_SCREEN = "\e[H\e[2J"
  MENU_OPTIONS = {
    1 => "Create contact",
    2 => "List all contacts"
  }

  def initialize(input, output)
    @input = input
    @output = output
  end

  def menu
    output.puts "#{CLEAR_SCREEN} :::Contacts management::: \n\nPlease choose a menu option:\n\n"
    MENU_OPTIONS.each do |number, option|
      output.puts "#{number} - #{option}"
    end
    output.print"---> "
    get_menu_option
  end

  def display_all(contacts)
    contacts.each {|contact| display(contact)}
  end

  def display(contact)
    output.puts "#{CLEAR_SCREEN}"
    contact.each do |field, entry|
      output.puts "#{format_for_display(field)}: #{entry}"
    end
  end

  def get_contact_details(fields)
    contact_details = {}
    output.puts "#{CLEAR_SCREEN}"
    fields.each do |field_name|
      output.puts "#{format_for_display(field_name)}:"
      contact_details[field_name] = input.gets.chomp
    end
    contact_details
  end

  def get_menu_option
    user_input = input.gets.chomp
    if valid_menu_option?(user_input)
      user_input.to_i
    else
      menu
    end
  end

  def valid_menu_option?(user_input)
    MENU_OPTIONS.key?(user_input.to_i)
  end

  def format_for_display(symbol)
    symbol.to_s.capitalize.split("_").join(" ")
  end
end
