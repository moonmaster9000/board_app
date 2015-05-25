require "board/entities/validations"
require "board/entities/standup_item"

module Board
  module Entities
    class Help
      include StandupItem

      add_attributes(
        :description,
        :date,
        :team_id,
      )

      include Validations

      validate_field :date, :required
      validate_field :description, :required
      validate_field :team_id, :required
    end
  end
end
