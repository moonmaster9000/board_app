require "board/use_cases/private/entities/validations"
require "board/use_cases/private/entities/standup_item"

module Board
  module Entities
    class Event
      include StandupItem

      add_attributes(
        :description,
        :title,
        :date,
        :whiteboard_id,
      )

      include Validations

      validate_field :date, :required
      validate_field :title, :required
      validate_field :whiteboard_id, :required
    end
  end
end
