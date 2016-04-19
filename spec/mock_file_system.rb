class MockFileSystem
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def open(file_name, action)
    yield file
  end

  def exist?(file_name)
  end

  def zero?(file_name)
    true
  end
end
