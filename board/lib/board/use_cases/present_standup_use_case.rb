module Board
  module UseCases
    class PresentStandupUseCase
      class << self
        def add_standup_item_collector(item_collector)
          standup_item_collectors << item_collector
        end

        def standup_item_collectors
          @standup_item_collectors ||= []
        end
      end

      def initialize(team_id:, observer:, repo_factory:)
        @repo_factory = repo_factory
        @observer = observer
        @team_id = team_id
        @items = {}
      end

      def execute
        collect_standup_items
        present_standup
      end

      def add_items(item_name, items)
        @items[item_name] = items
      end

      private
      def present_standup
        standup = Values::Standup.new(@items)
        @observer.standup_presented(standup)
      end

      def collect_standup_items
        standup_item_collectors.each do |item_collector|
          item_collector.call(repo_factory: @repo_factory, standup_use_case: self, team_id: @team_id)
        end
      end

      def standup_item_collectors
        self.class.standup_item_collectors
      end

      module Values
        class PresentHashKeysAsMethods
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

        class Standup < PresentHashKeysAsMethods
        end
      end
    end
  end
end

Dir[File.join(__dir__, "standup_item_collectors", "**", "*.rb")].each do |file|
  require file
end
