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
        @entity_name ||= begin
          demodulized_class_name = @entity_class.name.split("::").last
          demodulized_class_name.scan(/[A-Z][^A-Z]*/).map(&:downcase).join("_")
        end
      end
    end
  end
end
