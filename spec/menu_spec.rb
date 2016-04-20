require 'spec_helper'
require 'menu'

describe Menu do
  let (:menu) {Menu.new}

  it "knows that 'find a contact' was chosen" do
    expect(menu.find_contact(3)).to be true
  end

  it "knows that 'list contacts' was chosen" do
    expect(menu.list_contacts(2)).to be true
  end

  it "knows that 'create contact' was chosen" do
    expect(menu.create_contact(1)).to be true
  end

  it "translates the action into the corresponding number" do
    expect(menu.choose(:create_contact)).to eq 1
  end
end
