require "erb"
require "pathname"

class MarkdownStandupEmailFormatter
  def format_email(standup)
    template = File.read(File.join(__dir__, "email.markdown.erb"))
    items = ItemsCollection.new(standup.items)
    ERB.new(template).result binding
  end

  class ItemsCollection
    def initialize(items_hash)
      @items_hash = items_hash
    end

    def each
      @items_hash.each do |key, values|
        if values.empty?
          yield NullItems.new
        else
          yield Items.new(key, values)
        end
      end
    end

    class NullItems
      def heading
        ""
      end

      def body
        ""
      end
    end

    class Items
      attr_reader :name, :values

      def initialize(items_name, items_values)
        @name = items_name
        @values = items_values
      end

      def heading
        ERB.new(File.read(File.join(__dir__, "heading.markdown.erb"))).result binding
      end

      def body
        path = Pathname.new(File.join(__dir__, "#{name}_body.markdown.erb"))

        if path.file?
          ERB.new(File.read(path)).result binding
        end
      end
    end
  end
end
