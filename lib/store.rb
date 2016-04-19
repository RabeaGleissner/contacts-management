require 'yaml'

class Store
  FILE_NAME = "contacts_store.yml"

  def initialize(contacts_file = File, format_converter = YAML)
    @contacts_file = contacts_file
    @format_converter = format_converter
  end

  def persist(data)
    contacts = []
    if !contacts_file.zero?(FILE_NAME)
      contacts << read
      contacts << data
    else
      contacts << data
    end
      contacts_file.open(FILE_NAME, "w"){ |file| file.write(contacts.to_yaml)}
  end

  def read
    contacts = format_converter.load_file(FILE_NAME)
    contacts
  end

  private

  attr_reader :contacts_file, :format_converter
end
