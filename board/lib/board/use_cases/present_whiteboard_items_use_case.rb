require "board/values/whiteboard"

module Board
  module UseCases
    class PresentWhiteboardItemsUseCase
      class << self
        def collectors
          @collector ||= []
        end

        def add_collector(collector)
          collectors << collector
        end
      end

      def initialize(whiteboard_id:, observer:, repo_factory:)
        @repo_factory = repo_factory
        @observer = observer
        @whiteboard_id = whiteboard_id
        @items = {}
      end
      
      def add_items(item_name, items)
        @items[item_name] = items
      end

      def execute
        self.class.collectors.each do |collector|
          collector.call(repo_factory: @repo_factory, whiteboard_id: @whiteboard_id, whiteboard_items: self)
        end

        @observer.whiteboard_items_presented(Board::Values::Whiteboard.new(@items))
      end
    end
  end
end


Dir[File.join(__dir__, "**", "whiteboard_item_collectors", "*.rb")].each do |collector|
  require collector
end
