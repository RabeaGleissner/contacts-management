require 'yaml'

class MockParser
  def initialize(mock_file, contact_data = nil)
    @mock_file = mock_file
    @contact_data = contact_data
  end

  def load_file(file_name)
    contacts = []
    yaml_array = mock_file.data
    yaml_array.each do |string|
      contacts << YAML.load(string)
    end
    contacts.flatten.reverse
  end

  private

  attr_reader :mock_file, :contact_data
end
