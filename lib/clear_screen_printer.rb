class ClearScreenPrinter
  attr_reader :output
  CLEAR_SCREEN = "\e[H\e[2J"

  def initialize(output)
    @output = output
  end

  def puts_on_clear_screen(text)
    output.puts "#{CLEAR_SCREEN}#{text}"
  end

  def print(text)
    output.print "#{text}"
  end

  def puts(text)
    output.puts "#{text}"
  end
end
