def send_email(attributes:, email_client:, observer:)
end

describe "USE CASE: Email Standup" do
  context "Given valid email attributes" do
    let(:attributes) { valid_email_attributes }

    it "delivers the email appropriately" do
      send_email(
        attributes: attributes,
        email_client: email_client,
        observer: observer
      )

      expect(email_client.spy_sent_email.attributes).to include attributes
    end
  end

  def valid_email_attributes
    {
      from: "valid@email.address",
      to:   "valid@email.address",
      subject: "valid subject",
      body: "valid body",
    }
  end

  let(:email_client) { EmailClientSpy.new }

  class EmailClientSpy
    def send(email)
      @spy_sent_email = email
    end
    attr_reader :spy_sent_email
  end
end
