require 'spec_helper'
require 'app'
require 'fake_ui'
require 'fake_kernel'
require 'test_doubles/store_spy'
require 'test_data'
require 'menu'

describe App do
  let (:mock_store) {StoreSpy.new}
  let (:menu) {Menu.new}

  it "creates new contact" do
    app = App.new(menu, FakeUi.new([menu.choose(:create_contact)]), mock_store)
    app.run
    expect(mock_store.contact.length).to eq Creator::FIELDS.length
  end

  it "displays existing contacts" do
    fake_ui = FakeUi.new([menu.choose(:list_all_contacts)])
    app = App.new(menu, fake_ui, mock_store)
    app.run
    expect(fake_ui.displayed_all).to be true
  end

  it "shows menu options again when user wants to continue" do
    continue_choices = [true, false]
    fake_ui = FakeUi.new([menu.choose(:list_all_contacts), menu.choose(:list_all_contacts)], continue_choices)
    app = App.new(Menu.new, fake_ui, mock_store)
    app.run
    expect(fake_ui.menu_calls_count).to eq 2
  end

  it "searches for a specific contact" do
    fake_ui = FakeUi.new([menu.choose(:find_contact_by_first_name)])
    app = App.new(menu, fake_ui, StoreSpy.new([TestData::JON_DOE]))
    app.run
    expect(fake_ui.get_search_keyword).to be true
  end

  it "exits application" do
    fake_kernel = FakeKernel.new
    fake_ui = FakeUi.new([menu.choose(:exit_application)])
    app = App.new(Menu.new, fake_ui, mock_store, fake_kernel)
    app.run
    expect(fake_kernel.exit_was_called).to be true
  end

  it "catches exception when user interrupts with ctrl +c" do
    interrupting_ui = InterruptingUi.new
    app = App.new(Menu.new, interrupting_ui, mock_store)
    app.run
    expect(interrupting_ui.says_goodbye).to be true
  end

  class InterruptingUi
    attr_reader :says_goodbye

    def initialize
      @says_goodbye = false
    end

    def users_selected_action(options)
      raise Interrupt
    end

    def interruption_message
      @says_goodbye = true
    end
  end
end
