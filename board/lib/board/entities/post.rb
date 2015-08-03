require "board/entities/entity"

module Board
  module Entities
    class Post
      include Entity

      add_attributes(
        :whiteboard_id,
        :standup_date,
      )

    end
  end
end
