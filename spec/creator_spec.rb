require 'spec_helper'
require 'creator'
require 'fake_ui'
require 'app'

describe Creator do

  it "creates a new contact" do
    continue = false
    fake_ui = FakeUi.new(choose(:create_contact), continue,
                         ["Jane", "Dill", "jane@123.de", "11111", "@jane"])
    creator = Creator.new(fake_ui, App::FIELDS)

    expect(creator.create_contact).to eq({
      :first_name=>"Jane",
      :last_name=>"Dill",
      :email_address=>"jane@123.de",
      :mobile_number=>"11111",
      :twitter_handle =>"@jane"
    })
  end

  private

  def choose(action)
    [App::MENU_OPTIONS.key(action)]
  end
end
