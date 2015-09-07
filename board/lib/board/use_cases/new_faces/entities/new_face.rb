require "board/use_cases/private/shared/entities/validations"
require "board/use_cases/private/shared/entities/standup_item"

module Board
  module Entities
    class NewFace
      include StandupItem

      add_attributes(
        :name,
        :date,
        :whiteboard_id,
      )

      include Validations
      validate_field :name, :required
      validate_field :date, :required
      validate_field :whiteboard_id, :required
    end
  end
end
