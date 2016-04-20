require 'finder'
require 'creator'
require 'store'

class App
  def initialize(menu, ui, store, kernel = Kernel)
    @menu = menu
    @ui = ui
    @store = store
    @kernel = kernel
  end

  def run
    begin
      loop do
        execute(ui.users_selected_action(Menu::OPTIONS))
        break if user_quits?
      end
    rescue Interrupt
      ui.interruption_message
    end
  end

  private

  attr_reader :menu, :ui, :store, :kernel

  def execute(action)
    if menu.create_contact(action)
      Creator.new(ui, store).create_contact
    elsif menu.list_contacts(action)
      ui.display_all(store.read_from_file)
    elsif menu.find_contact(action)
      Finder.new(ui, store).find_by(Creator::FIELDS.first)
    else
      kernel.exit
    end
  end

  def user_quits?
    !ui.continue?
  end
end
