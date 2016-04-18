require 'yaml'

class Store
  FILE_NAME = "contacts_store.yml"

  def initialize(contacts_file = File, format_converter = YAML)
    @contacts_file = contacts_file
    @format_converter = format_converter
  end

  def persist(data)
    contacts_file.open(FILE_NAME, "w"){ |file| file.write(data.to_yaml)}
  end

  def read
    format_converter.load_file(FILE_NAME)
  end

  private

  attr_reader :contacts_file, :format_converter
end
