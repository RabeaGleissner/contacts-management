class ClearScreenPrinter
  attr_reader :output
  CLEAR_SCREEN = "\e[H\e[2J"

  def initialize(output)
    @output = output
  end

  def print(text)
    output.puts "#{CLEAR_SCREEN}#{text}"
  end
end
