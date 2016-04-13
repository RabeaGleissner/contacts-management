class Contact
  attr_reader :first_name, :last_name, :email, :mobile_number, :twitter

  def initialize(first_name, last_name, email, mobile_number, twitter)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @mobile_number = mobile_number
    @twitter = twitter
  end
end
