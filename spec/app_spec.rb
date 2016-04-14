require 'spec_helper'
require 'app'
require 'fake_ui'

describe App do
  it "creates a new contact" do
    app = App.new(FakeUi.new(App::MENU_OPTIONS.key("Create contact")))
    app.run
    expect(app.contacts.length).to eq 1
  end

  it "displays existing contacts" do
    fake_ui = FakeUi.new(App::MENU_OPTIONS.key("List all contacts"))
    app = App.new(fake_ui)
    app.contacts << {:first_name=>"Jon", :last_name=>"Doe", :email=>"jon@123.de", :mobile_number=>"00000", :twitter=>"@jon"}
    app.run
    expect(fake_ui.display_contacts_was_called).to be true
  end
end
