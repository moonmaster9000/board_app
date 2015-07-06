require "erb"
require "pathname"

class MarkdownStandupEmailFormatter
  def format_email(standup)
    template = File.read(File.join(__dir__, "email.erb"))
    item_categories = ItemCategories.new(standup.items)
    ERB.new(template).result binding
  end

  def content_type
    "text/html"
  end

  class ItemCategories
    def initialize(categories)
      @categories = categories
    end

    def each
      @categories.each do |category, items|
        if items.empty?
          yield NullItems.new
        else
          yield Items.new(category, items)
        end
      end
    end

    class NullItems
      def render
        ""
      end
    end

    class Items
      attr_reader :name, :values

      def initialize(items_name, items_values)
        @name = items_name
        @values = items_values
      end

      def render
        path = Pathname.new(File.join(__dir__, "#{name}.erb"))

        ERB.new(File.read(path)).result binding
      end

      private

      def markdown_to_html(text)
        require "github/markdown"
        GitHub::Markdown.render_gfm(text)
      end
    end
  end
end
