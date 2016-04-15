require 'spec_helper'
require 'finder'
require 'fake_ui'

describe Finder do
  it "finds a contact for a given keyword" do
    CONTACT_A = {:first_name=>"Jon", :last_name=>"Doe", :email=>"jon@123.de", :mobile_number=>"00000", :twitter=>"@jon"}
    CONTACT_B = {:first_name=>"Jane", :last_name=>"Dill", :email=>"jane@123.de", :mobile_number=>"11111", :twitter=>"@jane"}
    finder = Finder.new(FakeUi.new, [CONTACT_A, CONTACT_B])
    expect(finder.find_by(:first_name)).to eq [CONTACT_B]
  end
end
