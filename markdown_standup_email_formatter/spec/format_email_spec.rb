require "markdown_standup_email_formatter"
describe "markdown_standup_email_formatter" do
  context "Given an empty standup item" do
    let(:standup) do
      Class.new do
        def items
          {
            foos: [],
          }
        end
      end.new
    end

    specify "Then the email formatter won't render it" do
      email = MarkdownStandupEmailFormatter.new.format_email(standup)

      expect(email.downcase).not_to include("foos")
    end
  end

  context "Given a non-empty standup item" do
    let(:standup) do
      Class.new do
        def items
          {
            foos: ["foo"],
          }
        end
      end.new
    end

    specify "Then the email formatter will render that section" do
      email = MarkdownStandupEmailFormatter.new.format_email(standup)

      expect(email.downcase).to include("foos")
    end
  end
end
