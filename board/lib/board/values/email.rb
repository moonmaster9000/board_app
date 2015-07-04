module Board
  module Values
    class Email
      attr_reader(
        :to_address,
        :from_address,
        :body,
        :subject,
      )

      def initialize(to_address:, body:, from_address:, subject:)
        @from_address = from_address
        @to_address   = to_address
        @body         = body
        @subject      = subject
      end
    end
  end
end
