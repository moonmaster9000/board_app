module Board
  module Entities
    class NewFace
      attr_accessor :id
      def initialize(attributes={})
        @attributes = attributes
      end
    end
  end
end
