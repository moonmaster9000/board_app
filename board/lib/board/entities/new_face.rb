require "board/entities/entity"
require "board/entities/validations"

module Board
  module Entities
    class NewFace < Entity
      set_attributes(
        :id,
        :name,
        :date,
      )

      include Validations
      validate_field :name, :required
      validate_field :date, :required
    end
  end
end
