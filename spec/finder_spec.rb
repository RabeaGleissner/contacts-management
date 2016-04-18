require 'spec_helper'
require 'finder'
require 'fake_ui'

describe Finder do
    JON_DOE = {:first_name=>"Jon", :last_name=>"Doe", :email=>"jon@123.de", :mobile_number=>"00000", :twitter=>"@jon"}
    JANE_DILL = {:first_name=>"Jane", :last_name=>"Dill", :email=>"jane@123.de", :mobile_number=>"11111", :twitter=>"@jane"}
    JANE_MILLER = {:first_name=>"Jane", :last_name=>"Miller", :email=>"jane@456.de", :mobile_number=>"22222", :twitter=>"@jane_2"}

  it "finds a contact for a given keyword" do
    finder = Finder.new(FakeUi.new, [JON_DOE, JANE_DILL])
    expect(finder.search_result(:first_name, "Jane")).to eq [JANE_DILL]
  end

  it "finds both contacts with the same first name" do
    finder = Finder.new(FakeUi.new, [JANE_DILL, JANE_MILLER])
    expect(finder.search_result(:first_name, "Jane")).to eq [JANE_DILL, JANE_MILLER]
  end

  it "asks the Ui to display all contacts found" do
    fake_ui = FakeUi.new
    finder = Finder.new(fake_ui, [JON_DOE, JANE_DILL])
    fake_ui.set_search_keyword("Jane")
    finder.find_by(:first_name)
    expect(fake_ui.contact_details_to_display).to eq [JANE_DILL]
  end
end
