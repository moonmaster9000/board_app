require "board/use_cases/private/entities/standup_item"

module Board
  module Entities
    class NewFace < StandupItem
      add_attributes(
        :name,
        :date,
        :whiteboard_id,
      )

      validate_field :name, :required
      validate_field :date, :required
      validate_field :whiteboard_id, :required
    end
  end
end
