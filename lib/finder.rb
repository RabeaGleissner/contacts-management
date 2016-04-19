class Finder

  def initialize(ui, contacts)
    @ui = ui
    @contacts = contacts
  end

  def find_by(search_field)
    keyword = ui.ask_for_search_keyword(search_field)
    ui.display_all(search_result(search_field, keyword))
  end

  def search_result(search_field, keyword)
    contacts.select { |contact| contact[search_field] == keyword}
  end

  private

  attr_reader :ui, :contacts
end
