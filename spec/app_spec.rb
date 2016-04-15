require 'spec_helper'
require 'app'
require 'fake_ui'

describe App do
  it "creates new contact" do
    app = App.new(FakeUi.new([choose(:create_contact)]))
    app.run
    expect(app.contacts.length).to eq 1
  end

  it "displays existing contacts" do
    fake_ui = FakeUi.new([choose(:list_all_contacts)])
    app = App.new(fake_ui)
    app.run
    expect(fake_ui.display_all_was_called).to be true
  end

  it "shows menu options again when user wants to continue" do
    continue_choices = [true, false]
    fake_ui = FakeUi.new([choose(:list_all_contacts), choose(:list_all_contacts)], continue_choices)
    app = App.new(fake_ui)
    app.run
    expect(fake_ui.menu_calls_count).to eq 2
  end

  it "searches for a specific contact" do
    fake_ui = FakeUi.new([choose(:find_contact_by_first_name)])
    app = App.new(fake_ui)
    app.run
    expect(fake_ui.search_action_was_called).to be true
  end

  private

  def choose(action)
    App::MENU_OPTIONS.key(action)
  end
end
