require "date"

module TestAttributes
  extend self

  def valid_whiteboard_attributes
    { name: "Valid Name" }
  end

  def valid_standup_email_config_attributes
    {
      to_address: "to@address.com",
      from_address: "from@address.com",
      subject_prefix: "[fake subject prefix]",
    }
  end

  def valid_new_face_attributes
    { name: "Valid New Face Name", date: valid_date}
  end

  def valid_interesting_attributes
    { date: valid_date, title: "valid interesting title" }
  end

  def valid_event_attributes
    { date: valid_date, title: "valid event title" }
  end

  def invalid_event_attributes
    { date: nil, title: nil }
  end

  def valid_date
    Date.new(2011, 4, 4)
  end

  def valid_help_attributes
    { date: valid_date, description: "valid description" }
  end

end
