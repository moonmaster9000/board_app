require "board/use_cases/private/entities/entity"

module Board
  module Entities
    module StandupItem
      class << self
        def included(klass)
          make_entity(klass)
          add_archived_attributes(klass)
          force_archived_attr_to_be_boolean(klass)
          add_custom_archived_getter_and_setters(klass)
        end

        private

        def add_archived_attributes(klass)
          klass.add_attributes(:archived)
        end

        def make_entity(klass)
          klass.send :include, Entity
        end

        def force_archived_attr_to_be_boolean(klass)
          klass.class_eval do
            def archived
              !!@archived
            end
          end
        end

        def add_custom_archived_getter_and_setters(klass)
          klass.class_eval do
            def archived?
              archived == true
            end

            def archive!
              @archived = true
            end
          end
        end
      end
    end
  end
end
