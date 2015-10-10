require "board/use_cases/private/entities/validations"
require "board/use_cases/private/entities/standup_item"
require "board/use_cases/private/entities/private_attribute"

module Board
  module Entities
    class Event
      include StandupItem

      add_attributes(
        :description,
        :title,
        :date,
        :whiteboard_id,
        :private,
      )

      include Validations

      validate_field :date, :required
      validate_field :title, :required
      validate_field :whiteboard_id, :required

      include PrivateAttribute
    end
  end
end
