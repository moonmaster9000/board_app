require "board/use_cases/private/shared/entities/entity"
require "board/use_cases/private/shared/entities/validations"

module Board
  module Entities
    class Whiteboard
      include Entity

      add_attributes :name

      include Validations
      validate_field :name, :required
    end
  end
end
