require 'spec_helper'
require 'creator'
require 'fake_ui'
require 'app'
require 'test_data'

describe Creator do
  it "creates a new contact" do
    continue = false
    fake_ui = FakeUi.new(choose(:create_contact), continue,
                         ["Jane", "Dill", "jane@123.de", "11111", "@jane"])
    creator = Creator.new(fake_ui, App::FIELDS, Store.new)

    expect(creator.create_contact).to eq(TestData::JANE_DILL)
  end

  private

  def choose(action)
    [App::MENU_OPTIONS.key(action)]
  end
end
