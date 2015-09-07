def verify_session_contract(session_factory:)
  describe "Session" do
    it "keeps track of whether or not a user is logged in" do
      session = session_factory.call

      expect(session).not_to be_logged_in

      session.log_in

      expect(session).to be_logged_in
    end
  end
end
