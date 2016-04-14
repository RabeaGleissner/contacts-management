require 'spec_helper'
require 'stringio'
require 'ui'
require 'app'

describe Ui do
  let (:input) {StringIO.new}
  let (:output) {StringIO.new}

  CLEAR_SCREEN = "\e[H\e[2J"
  CONTACT_1 = {:first_name=>"Jon", :last_name=>"Doe", :email=>"jon@123.de", :mobile_number=>"00000", :twitter=>"@jon"}
  CONTACT_2 = {:first_name=>"Jane", :last_name=>"Dill", :email=>"jane@123.de", :mobile_number=>"11111", :twitter=>"@jane"}

  it "displays menu of options" do
    ui = Ui.new(StringIO.new("2"), output)
    ui.menu
    expect(output.string).to eq("#{CLEAR_SCREEN} :::Contacts management::: \n\nPlease choose a menu option:\n\n1 - Create contact\n2 - List all contacts\n---> ")
  end

  it "gets user input for menu choice" do
    ui = Ui.new(StringIO.new("2"), output)
    expect(ui.menu).to eq 2
  end

  it "knows that a letter is not a valid menu option" do
    ui = Ui.new(input, output)
    expect(ui.valid_menu_option?("n")).to be false
  end

   it "shows menu options again on invalid input" do
     ui = Ui.new(input, output)
     allow(ui.input).to receive(:gets).and_return("n", "2")
     ui.get_menu_option
     expect(output.string).to eq ("#{CLEAR_SCREEN} :::Contacts management::: \n\nPlease choose a menu option:\n\n1 - Create contact\n2 - List all contacts\n---> ")
   end

   it "gets user input for all fields of a contact" do
     ui = Ui.new(input, output)
     allow(ui.input).to receive(:gets).and_return("Jon", "Doe", "test@121.de", "093383", "@jon")
     ui.get_contact_details(App::FIELDS)
     expect(output.string).to eq ("#{CLEAR_SCREEN}\nFirst name:\nLast name:\nEmail:\nMobile number:\nTwitter:\n")
   end

   it "returns contact details entered by user" do
     ui = Ui.new(input, output)
     allow(ui.input).to receive(:gets).and_return("Jon", "Doe", "test@121.de", "093383", "@jon")
     expect(ui.get_contact_details(App::FIELDS)).to eq ({:first_name=>"Jon", :last_name=>"Doe", :email=>"test@121.de", :mobile_number=>"093383", :twitter=>"@jon"})
   end

   it "converts a ruby symbol into a displayable word" do
     ui = Ui.new(input, output)
     expect(ui.format_for_display(:first_name)).to eq "First name"
   end

   it "displays existing contact" do
     ui = Ui.new(input, output)
     ui.display(CONTACT_1)
     expect(output.string).to eq "#{CLEAR_SCREEN}\nFirst name: Jon\nLast name: Doe\nEmail: jon@123.de\nMobile number: 00000\nTwitter: @jon\n"
   end

   it "displays several contacts" do
     ui = Ui.new(input, output)
     ui.display_all([CONTACT_1, CONTACT_2])
     expect(output.string).to eq "#{CLEAR_SCREEN}\nFirst name: Jon\nLast name: Doe\nEmail: jon@123.de\nMobile number: 00000\nTwitter: @jon\n\e[H\e[2J\nFirst name: Jane\nLast name: Dill\nEmail: jane@123.de\nMobile number: 11111\nTwitter: @jane\n"
   end
end
