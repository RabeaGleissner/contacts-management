require 'spec_helper'
require 'app'
require 'fake_ui'

describe App do
  it "creates a new contact" do
    continue = [false]
    app = App.new(FakeUi.new([choose("Create contact")], continue))
    app.run
    expect(app.contacts.length).to eq 1
  end

  it "displays existing contacts" do
    continue = [false]
    fake_ui = FakeUi.new([choose("List all contacts")], continue)
    app = App.new(fake_ui)
    app.contacts << {:first_name=>"Jon", :last_name=>"Doe", :email=>"jon@123.de", :mobile_number=>"00000", :twitter=>"@jon"}
    app.run
    expect(fake_ui.display_contacts_was_called).to be true
  end

  it "shows menu options again after one action was executed" do
    continue = [true, false]
    fake_ui = FakeUi.new([choose("List all contacts"), choose("List all contacts")], continue)
    app = App.new(fake_ui)
    app.run
    expect(fake_ui.menu_calls_count).to eq 2
  end

  private

  def choose(action)
    App::MENU_OPTIONS.key(action)
  end
end
