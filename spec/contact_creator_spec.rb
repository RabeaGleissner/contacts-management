require 'spec_helper'
require 'contact_creator'

describe ContactCreator do
  let (:creator) {ContactCreator.new}

  it "creates new contact" do
    contact_details = {:first_name=>"Jon", :last_name=>"Doe", :email=>"email@test.com", :mobile_number=>"07879587", :twitter=>"@jondoe"}
    contact = creator.create(contact_details)
    expect(contact.first_name).to eq "Jon"
    expect(contact.last_name).to eq "Doe"
    expect(contact.email).to eq "email@test.com"
    expect(contact.mobile_number).to eq "07879587"
    expect(contact.twitter).to eq "@jondoe"
  end
end
