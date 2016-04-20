require 'spec_helper'
require 'app'
require 'fake_ui'
require 'fake_kernel'
require 'file_store_mocks/mock_store'
require 'test_data'

describe App do
  let (:mock_store) {MockStore.new}

  it "creates new contact" do
    app = App.new(FakeUi.new([choose(:create_contact)]), mock_store)
    app.run
    expect(mock_store.contact.length).to eq App::FIELDS.length
  end

  it "displays existing contacts" do
    fake_ui = FakeUi.new([choose(:list_all_contacts)])
    app = App.new(fake_ui, mock_store)
    app.run
    expect(fake_ui.display_all_was_called).to be true
  end

  it "shows menu options again when user wants to continue" do
    continue_choices = [true, false]
    fake_ui = FakeUi.new([choose(:list_all_contacts), choose(:list_all_contacts)], continue_choices)
    app = App.new(fake_ui, mock_store)
    app.run
    expect(fake_ui.menu_calls_count).to eq 2
  end

  it "searches for a specific contact" do
    fake_ui = FakeUi.new([choose(:find_contact_by_first_name)])
    app = App.new(fake_ui, MockStore.new([TestData::JON_DOE]))
    app.run
    expect(fake_ui.search_action_was_called).to be true
  end

  it "exits application" do
    fake_kernel = FakeKernel.new
    fake_ui = FakeUi.new([choose(:exit_application)])
    app = App.new(fake_ui, mock_store, fake_kernel)
    app.run
    expect(fake_kernel.exit_was_called).to be true
  end

  private

  def choose(action)
    App::MENU_OPTIONS.key(action)
  end
end
