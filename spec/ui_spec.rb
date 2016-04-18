require 'spec_helper'
require 'stringio'
require 'ui'
require 'clear_screen_printer'
require 'app'
require 'test_data'

describe Ui do
  let (:input) {StringIO.new}
  let (:output) {StringIO.new}

  CLEAR_SCREEN = "\e[H\e[2J"
  MENU_DISPLAY = "#{CLEAR_SCREEN} :::Contacts management::: \n\nPlease choose a menu option:\n\n1 - Create contact\n2 - List all contacts\n3 - Find contact by first name\n4 - Exit application\n\n---> "
  CONTINUE_QUESTION = "\nWould you like to continue? (y\\n)\n"
  OPTIONS = App::MENU_OPTIONS
  FIELDS = App::FIELDS


  it "displays the main menu" do
    ui = Ui.new(StringIO.new("2"), output)
    ui.display_menu(OPTIONS)
    expect(output.string).to eq MENU_DISPLAY
  end

  it "gets user's menu option choice" do
    ui = Ui.new(StringIO.new("2"), output)
    expect(ui.display_menu(OPTIONS)).to eq 2
  end

   it "shows menu options again on invalid input" do
     ui = Ui.new(input, output)
     allow(ui.input).to receive(:gets).and_return("n", "2")
     ui.display_menu(OPTIONS)
     expect(output.string).to eq (MENU_DISPLAY * 2)
   end

   it "displays all contacts" do
     ui = Ui.new(input, output)
     ui.display_all([TestData::JON_DOE, TestData::JANE_DILL])
     expect(output.string).to eq "#{CLEAR_SCREEN}\nFirst name: Jon\nLast name: Doe\nEmail address: jon@123.de\nMobile number: 00000\nTwitter handle: @jon\n---\nFirst name: Jane\nLast name: Dill\nEmail address: jane@123.de\nMobile number: 11111\nTwitter handle: @jane\n---\n"
   end

   it "displays a message if there are no contacts to display" do
     ui = Ui.new(input, output)
     ui.display_all([])
     expect(output.string).to include "\nSorry, there are no contacts to display!\n"
   end

   it "asks the user if they want to continue" do
     ui = Ui.new(StringIO.new("n"), output)
     ui.continue?
     expect(output.string).to eq CONTINUE_QUESTION
   end

   it "gets the user's choice for continuing or not" do
     ui = Ui.new(StringIO.new("y"), output)
     expect(ui.continue?).to eq true
   end

   it "asks again on bad input for continuation request" do
     ui = Ui.new(input, output)
     allow(ui.input).to receive(:gets).and_return("invalid", "n")
     ui.continue?
     expect(output.string).to eq (CONTINUE_QUESTION * 2)
   end

   it "displays error message if user tries to input an empty field" do
     ui = Ui.new(input, output)
     allow(ui.input).to receive(:gets).and_return("", "Jon")
     ui.details_for(:first_name)
     expect(output.string).to include "Each field is required. Please enter "
   end

   it "prompts the user to enter the first name to search a contact" do
     ui = Ui.new(StringIO.new("Jon"), output)
     ui.ask_for_search_keyword(:first_name)
     expect(output.string).to eq "\nEnter first name:\n"
   end

   it "returns the name that the user wants to search for" do
     ui = Ui.new(StringIO.new("Jon"), output)
     expect(ui.ask_for_search_keyword(:first_name)).to eq "Jon"
   end

   it "prompts for search keyword again if user leaves it blank" do
     ui = Ui.new(input, output)
     allow(ui.input).to receive(:gets).and_return("", "Jon")
     ui.ask_for_search_keyword(:first_name)
     expect(output.string).to include "Please provide the search keyword: "
   end

   it "confirms the creation of a contact" do
     ui = Ui.new(input, output)
     ui.confirm_contact_creation
     expect(output.string).to eq "\n\nContact created!\n"
   end
end
