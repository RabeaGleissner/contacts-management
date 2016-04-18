class MockConverter
  attr_reader :load_file_was_called

  def initialize
    @load_file_was_called = false
  end

  def load_file(file_name)
    @load_file_was_called = true
    file_name
  end
end
