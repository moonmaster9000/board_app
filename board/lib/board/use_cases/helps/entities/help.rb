require "board/use_cases/private/entities/validations"
require "board/use_cases/private/entities/standup_item"
require "board/use_cases/private/entities/private_attribute"

module Board
  module Entities
    class Help
      include StandupItem
      include PrivateAttribute

      add_attributes(
        :description,
        :date,
        :whiteboard_id,
      )

      include Validations

      validate_field :date, :required
      validate_field :description, :required
      validate_field :whiteboard_id, :required
    end
  end
end
