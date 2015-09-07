require "board/use_cases/private/shared/entities/validations"
require "board/use_cases/private/shared/entities/standup_item"

module Board
  module Entities
    class Help
      include StandupItem

      add_attributes(
        :description,
        :date,
        :whiteboard_id,
      )

      include Validations

      validate_field :date, :required
      validate_field :description, :required
      validate_field :whiteboard_id, :required
    end
  end
end
