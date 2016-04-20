class ClearScreenPrinter
  attr_reader :output
  CLEAR_SCREEN = "\e[H\e[2J"

  def initialize(output)
    @output = output
  end

  def puts_on_clear_screen(text)
    output.puts "#{CLEAR_SCREEN}#{text}"
  end

  def clear_screen
    output.puts CLEAR_SCREEN
  end
end
