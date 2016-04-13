require 'contact'

class ContactCreator
  def create(contact_details)
    Contact.new(contact_details[:first_name],
                contact_details[:last_name],
                contact_details[:email],
                contact_details[:mobile_number],
                contact_details[:twitter]
               )
  end
end
