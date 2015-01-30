module Board
  module Entities
    class Team
      attr_reader :name
      attr_accessor :id

      def initialize(name: nil)
        @name = name
      end
    end
  end
end
