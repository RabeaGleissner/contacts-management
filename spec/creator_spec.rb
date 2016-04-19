require 'spec_helper'
require 'creator'
require 'fake_ui'
require 'app'
require 'test_data'
require 'mock_store'

describe Creator do
  it "creates a new contact" do
    continue = false
    store = MockStore.new
    fake_ui = FakeUi.new(choose(:create_contact), continue,
                         ["Jane", "Dill", "jane@123.de", "11111", "@jane"])
    creator = Creator.new(fake_ui, App::FIELDS, store)
    creator.create_contact
    expect(store.contact).to eq(TestData::JANE_DILL)
  end

  private

  def choose(action)
    [App::MENU_OPTIONS.key(action)]
  end
end
