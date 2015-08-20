require "board/values/standup"

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

      def initialize(whiteboard_id:, observer:, date:, repo_factory:)
        @repo_factory = repo_factory
        @observer = observer
        @whiteboard_id = whiteboard_id
        @date = date
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
        standup = Board::Values::Standup.new(@items)
        @observer.standup_presented(standup)
      end

      def collect_standup_items
        standup_item_collectors.each do |item_collector|
          item_collector.call(
            repo_factory: @repo_factory,
            standup_use_case: self,
            whiteboard_id: @whiteboard_id,
            date: @date,
          )
        end
      end

      def standup_item_collectors
        self.class.standup_item_collectors
      end
    end
  end
end

Dir[File.join(__dir__, "**", "standup_item_collectors", "*.rb")].each do |file|
  require file
end
