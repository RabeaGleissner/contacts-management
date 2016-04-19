class MockFile
  attr_reader :data

  def initialize
    @data = []
  end

  def write(data)
    @data << data
  end
end
