require "board/use_cases/private/entities/standup_item"

module Board
  module Entities
    class Help < StandupItem
      add_attributes(
        :description,
        :date,
      )

      validate_field :date, :required
      validate_field :description, :required
    end
  end
end
