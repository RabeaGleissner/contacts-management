class Finder
  def initialize(ui, store)
    @ui = ui
    @store = store
  end

  def find_by(search_field)
    keyword = ui.ask_for_search_keyword(search_field)
    ui.display_all(search_result(search_field, keyword))
  end

  def search_result(search_field, keyword)
    contacts = store.read_from_file
    contacts.select { |contact| contact[search_field] == keyword}
  end

  private

  attr_reader :ui, :store
end
