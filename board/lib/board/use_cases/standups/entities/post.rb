require "board/use_cases/private/entities/entity"
require "board/use_cases/private/entities/validations"

module Board
  module Entities
    class Post < Entity
      add_attributes(
        :whiteboard_id,
        :standup_date,
        :title,
      )

      include Validations
      validate_field(:title, :required)
    end
  end
end
