module Board
  module UseCases
    class CreateEntityForTeamUseCase
      def initialize(attributes:, repo:, observer:, team_id:, entity_class:)
        @observer = observer
        @repo = repo
        @attributes = attributes
        @team_id = team_id
        @entity_class = entity_class
      end

      def execute
        if request_valid?
          persist
          send_presentable_entity_to_observer
        else
          send_validation_errors_to_observer
        end
      end

      private

      def send_validation_errors_to_observer
        @observer.validation_failed(entity.validation_errors)
      end

      def send_presentable_entity_to_observer
        @observer.send creation_succeeded_method_name, entity
      end

      def persist
        @repo.save(entity)
      end

      def request_valid?
        entity.valid?
      end

      def entity
        @entity ||= @entity_class.new(@attributes.merge(team_id: @team_id))
      end

      def creation_succeeded_method_name
        "#{entity_name}_created"
      end

      def entity_name
        @entity_name ||= turn_camelcase_into_snakecase(@entity_class.name)
      end

      def turn_camelcase_into_snakecase(camelcase_class_name)
        demodulized_class_name = camelcase_class_name.split("::").last
        each_camel_case_word_in_name = demodulized_class_name.scan(/[A-Z][^A-Z]*/)
        each_camel_case_word_in_name.map(&:downcase).join("_")
      end
    end
  end
end
