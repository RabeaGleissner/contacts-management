require 'yaml'

class MockParser
  def initialize(mock_file, contact_data = nil)
    @mock_file = mock_file
    @contact_data = contact_data
  end

  def load_file(file_name)
    mock_file.data.collect { |contact| YAML.load(contact)}.flatten.reverse
  end

  private

  attr_reader :mock_file, :contact_data
end
