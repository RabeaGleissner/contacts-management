require 'yaml'

class MockConverter
  def initialize(mock_file)
    @mock_file = mock_file
  end

  def load_file(file_name)
    contacts = []
    yaml_array = mock_file.data
    yaml_array.each do |string|
      contacts << YAML.load(string)
    end
    contacts.flatten
  end

  private

  attr_reader :mock_file
end
