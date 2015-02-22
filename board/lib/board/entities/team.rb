require "board/entities/entity"
require "board/validation_error"
require "board/entities/validations"

module Board
  module Entities
    class Team < Entity
      set_attributes(
        :name,
        :id,
      )

      include Validations
      validate_field :name, :required
    end
  end
end
