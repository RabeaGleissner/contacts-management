class Finder
  def initialize(ui, store)
    @ui = ui
    @store = store
  end

  def find_by(search_field)
    keyword = ui.ask_for_search_keyword(search_field)
    result = search_result(search_field, keyword)
    if result
      ui.display_all(result)
    else
      ui.no_contacts_to_display_message
    end
  end

  def search_result(search_field, keyword)
    contacts = store.read_from_file
    if contacts
      contacts.select { |contact| contact[search_field] == keyword}
    end
  end

  private

  attr_reader :ui, :store
end
