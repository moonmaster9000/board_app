require 'date'

module TestAttributes
  extend self

  def valid_team_attributes
    { name: "Valid Name" }
  end

  def valid_new_face_attributes
    { name: 'Valid New Face Name', date: Date.new(2011, 4, 4) }
  end
end
