class MockFile
  attr_reader :data

  def initialize
    @data = nil
  end

  def write(data)
    @data = [data]
  end
end
