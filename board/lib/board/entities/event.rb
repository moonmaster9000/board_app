require "board/entities/entity"
require "board/entities/validations"

module Board
  module Entities
    class Event < Entity
      set_attributes(
        :description,
        :title,
        :date,
        :team_id,
        :id,
      )

      include Validations

      validate_field :date, :required
      validate_field :title, :required
      validate_field :team_id, :required
    end
  end
end
