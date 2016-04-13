require 'spec_helper'
require 'stringio'
require 'ui'

describe Ui do
  let (:input) {StringIO.new}
  let (:output) {StringIO.new}
  let (:ui) {Ui.new(input, output)}

  CLEAR_SCREEN = "\e[H\e[2J"

  it "displays menu of options" do
    ui.menu
    expect(output.string).to eq("#{CLEAR_SCREEN} :::Contacts management::: \n\nPlease choose a menu option:\n\n1 - Create contact\n2 - List all contacts\n--->")
  end

  it "gets user input for menu choice" do
    ui = Ui.new(StringIO.new("2"), output)
    expect(ui.menu).to eq 2
  end
end
