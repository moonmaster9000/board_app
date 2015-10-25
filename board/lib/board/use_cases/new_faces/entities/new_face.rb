require "board/use_cases/private/entities/standup_item"

module Board
  module Entities
    class NewFace < StandupItem
      add_attributes(
        :name,
        :date,
      )

      validate_field :name, :required
      validate_field :date, :required
    end
  end
end
