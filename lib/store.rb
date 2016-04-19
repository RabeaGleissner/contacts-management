require 'yaml'

class Store
  FILE_NAME = "contacts_store.yml"

  def initialize(contacts_file = File, parser = YAML)
    @contacts_file = contacts_file
    @parser = parser
  end

  def persist(new_data)
    if contacts_exist?
      contacts = load_existing_contacts
      contacts << new_data
    else
      contacts = [new_data]
    end
    contacts_file.open(FILE_NAME, "w"){ |file| file.write(contacts.to_yaml)}
  end

  def read_from_file
    parser.load_file(FILE_NAME)
  end

  private

  attr_reader :contacts_file, :parser

  def contacts_exist?
    !contacts_file.zero?(FILE_NAME)
  end

  def load_existing_contacts
    read_from_file.select{ |contact| contact}
  end
end
