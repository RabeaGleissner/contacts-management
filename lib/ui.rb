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
    output.print"--->"
    get_menu_option
  end

  def get_menu_option
    input.gets.chomp.to_i
  end
end
