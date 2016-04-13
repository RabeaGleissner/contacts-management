class Contact
  attr_reader :first_name, :last_name, :email, :mobile, :twitter

  def initialize(first_name, last_name, email, mobile, twitter)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @mobile = mobile
    @twitter = twitter
  end
end
