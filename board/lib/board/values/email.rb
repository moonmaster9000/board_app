module Board
  module Values
    class Email
      attr_reader(
        :to_address,
        :from_address,
        :body,
        :subject,
        :content_type,
      )

      def initialize(to_address:, body:, from_address:, subject:, content_type:)
        @from_address = from_address
        @to_address   = to_address
        @body         = body
        @subject      = subject
        @content_type = content_type
      end
    end
  end
end
