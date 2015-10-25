require "board/use_cases/private/entities/entity"
require "board/use_cases/private/entities/validations"

module Board
  module Entities
    class Whiteboard < Entity
      add_attributes :name

      include Validations

      validate_field :name, :required
    end
  end
end
