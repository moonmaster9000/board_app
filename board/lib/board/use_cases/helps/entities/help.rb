require "board/use_cases/private/entities/standup_item"

module Board
  module Entities
    class Help < StandupItem
      add_attributes(
        :title,
        :description,
        :date,
      )

      validate_field :title,  :required
      validate_field :date,   :required
    end
  end
end
