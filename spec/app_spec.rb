require 'spec_helper'
require 'app'
require 'fake_ui'

describe App do
  it "creates a new contact" do
    app = App.new(FakeUi.new)
    expect(app.run).to eq ({
     :first_name=>"Jon",
     :last_name=>"Doe",
     :email=>"jon@123.de",
     :mobile_number=>"00000",
     :twitter=>"@jon"
    })
  end
end
