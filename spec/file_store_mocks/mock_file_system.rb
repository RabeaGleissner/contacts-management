class MockFileSystem
  def initialize(file)
    @file = file
  end

  def open(file_name, action)
    yield file
  end

  def exist?(file_name)
  end

  def zero?(file_name)
    file.data == nil
  end

  private

  attr_reader :file
end
