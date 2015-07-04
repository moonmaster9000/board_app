require "board/entities/validations"
require "board/entities/entity"

module Board
  module Entities
    class StandupEmailConfig
      include Entity
      include Validations

      add_attributes(
        :whiteboard_id,
        :to_address,
        :from_address,
        :subject_prefix,
      )
    end
  end
end
