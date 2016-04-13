require 'spec_helper'
require 'contact'

describe Contact do
  it "has a first name, last name, email, mobile number and twitter handle" do
    contact = Contact.new("first", "last", "email", "0292929", "twitter")
  end
end
