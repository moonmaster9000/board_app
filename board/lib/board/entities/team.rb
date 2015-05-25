require "board/entities/entity"
require "board/validation_error"
require "board/entities/validations"

module Board
  module Entities
    class Team
      include Entity

      add_attributes :name

      include Validations
      validate_field :name, :required
    end
  end
end
