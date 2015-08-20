class WordpressClient
  def initialize(username:, password:, host:)
    @username = username
    @password = password
    @host = host
  end

  def post(title:, standup:)
    client.newPost(
      content: {
        post_status: "publish",
        post_date: Time.now,
        post_title: title,
        post_content: body(standup),
      },
    )
  end

  private

  def client
    require "rubypress"

    @client ||= Rubypress::Client.new(
      username: @username,
      password: @password,
      host: @host,
      use_ssl: true,
    )
  end

  def body(standup)
    require "erb"

    render_erb("post_body.markdown.erb", binding)
  end

  def render_erb(file, closure)
    ERB.new(File.read(File.join(__dir__, file))).result closure
  end

  def render_items(item_name, item_values)
    render_erb("#{item_name}.markdown.erb", binding)
  end
end
