module Board
  module UseCases
    class PresentStandupUseCase
      PRESENT_ITEM_USE_CASES = []

      def initialize(team_id:, observer:, repo_factory:)
        @repo_factory = repo_factory
        @observer = observer
        @team_id = team_id
        @items = {}
      end

      def execute
        present_items_to_standup
        present_standup
      end

      def present_items(item_name, items)
        @items[item_name] = items
      end

      private
      def present_standup
        standup = Values::Standup.new(@items)
        @observer.standup_presented(standup)
      end

      def present_items_to_standup
        PRESENT_ITEM_USE_CASES.each do |present_item|
          present_item.call(repo_factory: @repo_factory, observer: self, team_id: @team_id)
        end
      end

      module Values
        class Standup
          def initialize(items)
            @items = items
          end

          def method_missing(method_name, *args, &block)
            if @items.has_key?(method_name)
              @items[method_name]
            else
              super
            end
          end
        end
      end
    end
  end
end

Dir[File.join(__dir__, "presents_items_use_cases", "**", "*.rb")].each do |file|
  require file
end
