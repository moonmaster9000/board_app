require "erb"
require "pathname"

class MarkdownStandupEmailFormatter
  def format_email(standup)
    email_template = File.read(File.join(__dir__, "email.erb"))
    ERB.new(email_template).result binding
  end

  def content_type
    "text/html"
  end

  def render_items(item_name, item_values)
    ERB.new(File.read(File.join(__dir__, "#{item_name}.erb"))).result binding
  end

  def markdown_to_html(text)
    require "github/markdown"
    GitHub::Markdown.render_gfm(text)
  end
end
