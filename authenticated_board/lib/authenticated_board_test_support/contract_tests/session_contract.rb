def assert_works_like_session(session_factory:)
  describe "Session Repo" do
    specify "it keeps track of whether or not a user is logged in" do
      repo = session_factory.call

      expect(repo).not_to be_logged_in

      repo.log_in

      expect(repo).to be_logged_in
    end
  end
end
