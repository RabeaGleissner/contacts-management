class Ui
  attr_reader :input, :output

  CLEAR_SCREEN = "\e[H\e[2J"

  def initialize(input, output)
    @input = input
    @output = output
  end

  def menu(options)
    output.puts "#{CLEAR_SCREEN} :::Contacts management::: \n\nPlease choose a menu option:\n\n"
    options.each do |number, option|
      output.puts "#{number} - #{option}"
    end
    output.print"---> "
    get_menu_option(options)
  end

  def display_all(contacts)
    if contacts.length >= 1
      contacts.each {|contact| display(contact)}
    else
      output.puts "Sorry, there are no contacts to display!"
    end
  end

  def continue?
    output.puts "Would you like to continue? (y\\n)"
    get_continue_request
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

  private

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
      menu(options)
    end
  end

  def valid_menu_option?(user_input, options)
    options.key?(user_input.to_i)
  end

  def format_for_display(symbol)
    symbol.to_s.capitalize.split("_").join(" ")
  end
end
