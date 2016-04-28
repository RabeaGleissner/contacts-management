require 'spec_helper'
require 'creator'
require 'fake_ui'
require 'menu'
require 'file_store_mocks/mock_store'

describe Creator do
  it "creates a new contact" do
    continue = false
    store = MockStore.new
    #FakeUI.choosing(:create_contact)
          #.userWillEnter(.....)
          #.willExit()
    fake_ui = FakeUi.new([Menu.new.choose(:create_contact)], continue,
                         ["Jane", "Dill", "jane@123.de", "11111", "@jane"])
    creator = Creator.new(fake_ui, store)
    creator.create_contact
    #expect(store.contact.first_name).to eq("Jane")
  end
end
