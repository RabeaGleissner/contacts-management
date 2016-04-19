require 'yaml'

class Store
  FILE_NAME = "contacts_store.yml"

  def initialize(contacts_file = File, format_converter = YAML)
    @contacts_file = contacts_file
    @format_converter = format_converter
  end

  def persist(new_data)
    contacts = []
    if contacts_exist?
      contacts = load_existing_contacts
      contacts << new_data
    else
      contacts << new_data
    end
    contacts_file.open(FILE_NAME, "w"){ |file| file.write(contacts.to_yaml)}
  end

  def read_from_file
    format_converter.load_file(FILE_NAME)
  end

  private

  attr_reader :contacts_file, :format_converter

  def contacts_exist?
    !contacts_file.zero?(FILE_NAME)
  end

  def load_existing_contacts
    read_from_file.select{ |contact| contact}
  end
end