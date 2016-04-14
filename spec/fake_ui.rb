class FakeUi
  def menu
    1
  end

  def get_contact_details(field)
    {
     :first_name=>"Jon",
     :last_name=>"Doe",
     :email=>"jon@123.de",
     :mobile_number=>"00000",
     :twitter=>"@jon"
    }
  end

end
