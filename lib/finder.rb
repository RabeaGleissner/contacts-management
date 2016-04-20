class Finder
  def initialize(ui, store)
    @ui = ui
    @store = store
  end

  def find_by(search_field)
    result = search_result(search_field, ui.ask_for_search_keyword(search_field))
    if result
      ui.display_all(result)
    else
      ui.no_contacts_to_display_message
    end
  end

  def search_result(search_field, keyword)
    contacts = store.read_from_file
    contacts.select { |contact| contact[search_field] == keyword} if contacts
  end

  private

  attr_reader :ui, :store
end
