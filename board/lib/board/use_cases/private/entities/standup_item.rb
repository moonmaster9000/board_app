require "board/use_cases/private/entities/entity"
require "board/use_cases/private/entities/validations"

module Board
  module Entities
    class StandupItem < Entity
      include Validations

      add_attributes(
        :archived,
        :whiteboard_id,
        :private,
      )

      validate_field :whiteboard_id, :required
      validate_field :private, :inclusion, values: [true, false]

      def archived
        !!@archived
      end

      def archived?
        archived == true
      end

      def archive!
        @archived = true
      end

      def private
        if @private.nil?
          true
        else
          @private
        end
      end
    end
  end
end
