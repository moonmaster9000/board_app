require "board/use_cases/private/entities/standup_item"


module Board
  module Entities
    class Interesting < StandupItem
      add_attributes(
        :description,
        :title,
        :date,
      )

      validate_field :date, :required
      validate_field :title, :required
    end
  end
end
