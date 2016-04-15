class Creator
  attr_reader :ui, :fields

  def initialize(ui, fields)
    @ui = ui
    @fields = fields
  end

  def create
    new_contact = {}
    fields.each do |field_name|
      new_contact[field_name] = ui.details_for(field_name)
    end
    new_contact
  end
end
