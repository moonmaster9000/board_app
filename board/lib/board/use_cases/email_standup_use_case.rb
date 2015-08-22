require "board/values/email"
require "board/use_case_factory"

module Board
  module UseCases
    class EmailStandupUseCase
      def initialize(email_client:, observer:, standup_email_formatter:, whiteboard_id:, date:, repo_factory:, attributes: {})
        @email_client = email_client
        @observer = observer
        @standup_email_formatter = standup_email_formatter
        @whiteboard_id = whiteboard_id
        @date = date
        @repo_factory = repo_factory
        @attributes = attributes
      end

      def execute
        if email_configured?
          format_and_send_standup_email
        else
          @observer.email_not_configured
        end
      end

      def format_and_send_standup_email
        Board::UseCaseFactory.new.present_standup(
          whiteboard_id: @whiteboard_id,
          observer: emails_standup_observer,
          date: @date,
          repo_factory: @repo_factory
        ).execute
      end

      private

      def email_configured?
        !!email_config
      end

      def email_config
        @repo_factory.standup_email_config_repo.find_by_whiteboard_id(@whiteboard_id)
      end

      def emails_standup_observer
        EmailsStandupObserver.new(
          email_config: email_config,
          standup_email_formatter: @standup_email_formatter,
          email_client: @email_client,
          whiteboard_id: @whiteboard_id,
          observer: @observer,
          attributes: @attributes,
        )
      end

      class EmailsStandupObserver
        def initialize(standup_email_formatter:, email_client:, whiteboard_id:, observer:, attributes:, email_config:)
          @standup_email_formatter = standup_email_formatter
          @email_client = email_client
          @whiteboard_id = whiteboard_id
          @observer = observer
          @attributes = attributes
          @email_config = email_config
        end

        def standup_presented(standup)
          email = generate_email(standup)
          send_email(email)
          notify_observer_email_sent(email)
        end

        private
        attr_reader(
          :email_config,
          :standup_email_formatter,
          :attributes,
          :email_client,
          :observer
        )

        def generate_email(standup)
          email_body    = standup_email_formatter.format_email(standup)

          Values::Email.new(
            from_address:   email_config.from_address,
            to_address:     email_config.to_address,
            body:           email_body,
            subject:        subject(email_config),
            content_type:   standup_email_formatter.content_type,
          )
        end

        def subject(email_config)
          [email_config.subject_prefix, attributes[:subject]].join(" ")
        end

        def send_email(email)
          email_client.send_email(email)
        end

        def notify_observer_email_sent(email)
          observer.email_sent(email)
        end
      end
    end
  end
end
