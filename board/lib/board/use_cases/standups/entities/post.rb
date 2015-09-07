require "board/use_cases/private/shared/entities/entity"
require "board/use_cases/private/shared/entities/validations"

module Board
  module Entities
    class Post
      include Entity
      include Validations

      add_attributes(
        :whiteboard_id,
        :standup_date,
        :title,
      )

      validate_field(:title, :required)
    end
  end
end
