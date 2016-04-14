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

  it "displays a menu of options" do
    ui = Ui.new(StringIO.new("2"), output)
    ui.menu(App::MENU_OPTIONS)
    expect(output.string).to eq("#{CLEAR_SCREEN} :::Contacts management::: \n\nPlease choose a menu option:\n\n1 - Create contact\n2 - List all contacts\n---> ")
  end

  it "gets user input for a menu choice" do
    ui = Ui.new(StringIO.new("2"), output)
    expect(ui.menu(App::MENU_OPTIONS)).to eq 2
  end

   it "shows menu options again on invalid input" do
     ui = Ui.new(input, output)
     allow(ui.input).to receive(:gets).and_return("n", "2")
     ui.menu(App::MENU_OPTIONS)
     expect(output.string).to eq (("#{CLEAR_SCREEN} :::Contacts management::: \n\nPlease choose a menu option:\n\n1 - Create contact\n2 - List all contacts\n---> ") * 2)
   end

   it "gets user input for all fields of a contact" do
     ui = Ui.new(input, output)
     allow(ui.input).to receive(:gets).and_return("Jon", "Doe", "test@121.de", "093383", "@jon")
     ui.get_contact_details(App::FIELDS)
     expect(output.string).to eq ("#{CLEAR_SCREEN}\nFirst name:\nLast name:\nEmail:\nMobile number:\nTwitter:\n")
   end

   it "returns contact details entered by a user" do
     ui = Ui.new(input, output)
     allow(ui.input).to receive(:gets).and_return("Jon", "Doe", "test@121.de", "093383", "@jon")
     expect(ui.get_contact_details(App::FIELDS)).to eq ({:first_name=>"Jon", :last_name=>"Doe", :email=>"test@121.de", :mobile_number=>"093383", :twitter=>"@jon"})
   end

   it "displays an existing contact" do
     ui = Ui.new(input, output)
     ui.display(CONTACT_1)
     expect(output.string).to eq "#{CLEAR_SCREEN}\nFirst name: Jon\nLast name: Doe\nEmail: jon@123.de\nMobile number: 00000\nTwitter: @jon\n"
   end

   it "displays several contacts" do
     ui = Ui.new(input, output)
     ui.display_all([CONTACT_1, CONTACT_2])
     expect(output.string).to eq "#{CLEAR_SCREEN}\nFirst name: Jon\nLast name: Doe\nEmail: jon@123.de\nMobile number: 00000\nTwitter: @jon\n\e[H\e[2J\nFirst name: Jane\nLast name: Dill\nEmail: jane@123.de\nMobile number: 11111\nTwitter: @jane\n"
   end

   it "displays a message if there are no contacts to display" do
     ui = Ui.new(input, output)
     ui.display_all([])
     expect(output.string).to eq "Sorry, there are no contacts to display!\n"
   end

   it "asks the user if they want to continue" do
     ui = Ui.new(input, output)
     allow(ui.input).to receive(:gets).and_return("n")
     ui.continue?
     expect(output.string).to eq "Would you like to continue? (y\\n)\n"
   end

   it "gets the users choice for continuing or not" do
     ui = Ui.new(StringIO.new("y"), output)
     expect(ui.continue?).to eq true
   end

   it "asks again on bad input for continuation request" do
     ui = Ui.new(input, output)
     allow(ui.input).to receive(:gets).and_return("invalid", "n")
     ui.continue?
     expect(output.string).to eq (("Would you like to continue? (y\\n)\n") * 2)
   end
end
