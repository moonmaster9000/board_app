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

    ERB.new(File.read(File.join(__dir__, "post_body.markdown.erb"))).result binding
  end

  def render_items(item_name, item_values)
    ERB.new(File.read(File.join(__dir__, "#{item_name}.markdown.erb"))).result binding
  end
end
