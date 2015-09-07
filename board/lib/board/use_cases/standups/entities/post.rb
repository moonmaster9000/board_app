require "board/use_cases/private/entities/entity"
require "board/use_cases/private/entities/validations"

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
