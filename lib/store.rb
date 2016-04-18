require 'yaml'

class Store
  FILE_NAME = "contacts_store.yml"

  def initialize(contacts_file)
    @contacts_file = contacts_file
  end

  def persist(data)
    contacts_file.open(FILE_NAME, "w"){ |file| file.write(data.to_yaml)}
  end

  private

  attr_reader :contacts_file
end
