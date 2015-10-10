module Board
  module Entities
    module PrivateAttribute
      def self.included(klass)
        klass.instance_eval do
          add_attributes :private

          include Validations
          validate_field :private, :inclusion, values: [true, false]
        end

        klass.class_eval do
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
  end
end
