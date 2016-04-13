require 'spec_helper'
require 'stringio'
require 'ui'

describe Ui do
  let (:input) {StringIO.new}
  let (:output) {StringIO.new}

  CLEAR_SCREEN = "\e[H\e[2J"

  it "displays menu of options" do
    ui = Ui.new(StringIO.new("2"), output)
    ui.menu
    expect(output.string).to eq("#{CLEAR_SCREEN} :::Contacts management::: \n\nPlease choose a menu option:\n\n1 - Create contact\n2 - List all contacts\n--->")
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
     expect(output.string).to eq ("#{CLEAR_SCREEN} :::Contacts management::: \n\nPlease choose a menu option:\n\n1 - Create contact\n2 - List all contacts\n--->")
   end

   it "gets user input for all fields of a contact" do
     ui = Ui.new(input, output)
     allow(ui.input).to receive(:gets).and_return("Jon", "Doe", "test@121.de", "093383", "@jon")
     ui.contact_details
     expect(output.string).to eq ("#{CLEAR_SCREEN}\nFirst name:\nLast name:\nEmail:\nMobile number:\nTwitter:\n")
   end

   it "returns contact details entered by user" do
     ui = Ui.new(input, output)
     allow(ui.input).to receive(:gets).and_return("Jon", "Doe", "test@121.de", "093383", "@jon")
     expect(ui.contact_details).to eq ({:first_name=>"Jon", :last_name=>"Doe", :email=>"test@121.de", :mobile_number=>"093383", :twitter=>"@jon"})
   end

   it "converts a ruby symbol into a displayable word" do
     ui = Ui.new(input, output)
     expect(ui.format_for_display(:first_name)).to eq "First name"
   end
end
