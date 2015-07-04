require "support/common_assertions"
require "board_test_support/doubles/gui_spy"
require "support/board_test_dsl"


describe "USE CASE: Email Standup" do
  include CommonAssertions
  include BoardTestDSL

  context "Given a valid whiteboard id" do
    before do
      @whiteboard = create_whiteboard
    end

    context "And the whiteboard has not been configured for email" do
      specify "Then the email standup use case should notify the observer that email has yet to be configured" do
        email_standup(
          email_client: email_client,
          observer: observer,
          standup_email_formatter: standup_email_formatter,
          whiteboard_id: @whiteboard.id,
          date: some_date,
        )

        expect(observer.spy_email_not_configured).to be(true)
      end
    end

    context "And the whiteboard has been configured for email" do
      before do
        @standup_email_config = create_standup_email_config(whiteboard_id: @whiteboard.id)
      end

      context "When I execute the email_standup_use_case for that whiteboard id" do
        before do
          email_standup(
            email_client: email_client,
            observer: observer,
            standup_email_formatter: standup_email_formatter,
            whiteboard_id: @whiteboard.id,
            date: some_date,
            attributes: {
              subject: custom_subject,
            }
          )
        end

        specify "Then the email_client should send an email to the configured 'to' address" do
          expect(email_client.spy_sent_email.to_address).to eq(@standup_email_config.to_address)
        end

        specify "And the email_client should send that email from the configured 'from' address" do
          expect(email_client.spy_sent_email.from_address).to eq(@standup_email_config.from_address)
        end

        specify "And the email_client should send that email with the subject prefix prepended to the provided subject" do
          expect(email_client.spy_sent_email.subject.start_with?(@standup_email_config.subject_prefix)).to be(true)
          expect(email_client.spy_sent_email.subject).to include(custom_subject)
        end

        specify "And the email_client should send the body provided by the standup_email_formatter" do
          expect(email_client.spy_sent_email.body).to eq(stubbed_standup_email_content)
        end

        specify "And it should notify the observer of success with the sent email" do
          expect(observer.spy_email_sent).to eq(email_client.spy_sent_email)
        end
      end
    end
  end

  let(:email_client) { EmailClientSpy.new }
  let(:observer) { GuiSpy.new }
  let(:some_date) { Date.today }
  let(:standup_email_formatter) { StandupEmailFormatterStub.new(stubbed_standup_email_content) }
  let(:stubbed_standup_email_content) { "stubbed standup email body" }
  let(:custom_subject) { "custom subject" }

  class EmailClientSpy
    def send_email(email)
      @spy_sent_email = email
    end
    attr_reader :spy_sent_email
  end


  class StandupEmailFormatterStub
    def initialize(email_stub)
      @email_stub = email_stub
    end

    def format_email(standup)
      @email_stub
    end
  end
end
