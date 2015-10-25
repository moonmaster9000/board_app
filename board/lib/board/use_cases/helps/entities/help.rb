require "board/use_cases/private/entities/standup_item"

module Board
  module Entities
    class Help < StandupItem
      add_attributes(
        :description,
        :date,
        :whiteboard_id,
      )

      validate_field :date, :required
      validate_field :description, :required
      validate_field :whiteboard_id, :required
    end
  end
end
