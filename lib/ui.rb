class Ui
  attr_reader :input, :output

  FIELDS = ["First name", "Last name", "Email", "Mobile number", "Twitter"]

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
    output.print"--->"
    get_menu_option
  end

  def contact_details
    details = []
    output.puts "#{CLEAR_SCREEN}"
    FIELDS.each do |field|
      output.puts "#{field}:"
      details << input.gets
    end
    details
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
end
