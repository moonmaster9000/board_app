def assert_works_like_session_repo(session_repo_factory:)
  describe "Session Repo" do
    specify "it keeps track of whether or not a user is logged in" do
      repo = session_repo_factory.call

      expect(repo).not_to be_logged_in

      repo.log_in(double(:user_dummy))

      expect(repo).to be_logged_in
    end
  end
end
