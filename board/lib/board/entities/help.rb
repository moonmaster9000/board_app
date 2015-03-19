require "board/entities/entity"
require "board/validation_error"
require "board/entities/validations"

module Board
  module Entities
    class Help < Entity
      set_attributes(
        :description,
        :date,
        :team_id,
        :id,
      )

      include Validations

      validate_field :date, :required
      validate_field :description, :required
      validate_field :team_id, :required
    end
  end
end
