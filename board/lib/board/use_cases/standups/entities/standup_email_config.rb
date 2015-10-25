require "board/use_cases/private/entities/validations"
require "board/use_cases/private/entities/entity"

module Board
  module Entities
    class StandupEmailConfig < Entity
      add_attributes(
        :whiteboard_id,
        :to_address,
        :from_address,
        :subject_prefix,
      )

      include Validations

      validate_field :from_address, :required
      validate_field :to_address, :required
      validate_field :whiteboard_id, :required
    end
  end
end
