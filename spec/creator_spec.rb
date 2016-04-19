require 'spec_helper'
require 'creator'
require 'fake_ui'
require 'menu'
require 'test_data'
require 'file_store_mocks/mock_store'

describe Creator do
  it "creates a new contact" do
    continue = false
    store = MockStore.new
    fake_ui = FakeUi.new([Menu.new.choose(:create_contact)], continue,
                         ["Jane", "Dill", "jane@123.de", "11111", "@jane"])
    creator = Creator.new(fake_ui, store)
    creator.create_contact
    expect(store.contact).to eq(TestData::JANE_DILL)
  end
end
