require 'spec_helper'
require 'finder'
require 'fake_ui'
require 'test_data'
require 'test_doubles/store_spy'

describe Finder do
  it "finds a contact for a given keyword" do
    finder = Finder.new(FakeUi.new,
                        StoreSpy.new([TestData::JON_DOE, TestData::JANE_DILL])
                       )
    expect(finder.search_result(:first_name, "Jane")).to eq [TestData::JANE_DILL]
  end

  it "finds both contacts with the same first name" do
    finder = Finder.new(FakeUi.new,
                        StoreSpy.new([TestData::JANE_DILL, TestData::JANE_MILLER])
                       )
    expect(finder.search_result(:first_name, "Jane")).to eq [TestData::JANE_DILL, TestData::JANE_MILLER]
  end

  it "asks the Ui to display all contacts found" do
    fake_ui = FakeUi.new
    finder = Finder.new(fake_ui,
                        StoreSpy.new([TestData::JON_DOE, TestData::JANE_DILL])
                       )
    fake_ui.set_search_keyword("Jane")
    finder.find_by(:first_name)
    expect(fake_ui.contact_details_to_display).to eq [TestData::JANE_DILL]
  end

  it "displays an error message if no contacts exist" do
    fake_ui = FakeUi.new
    finder = Finder.new(fake_ui, StoreSpy.new)
    fake_ui.set_search_keyword("Jane")
    finder.find_by(:first_name)
    expect(fake_ui.display_no_contact_error).to be true
  end
end
