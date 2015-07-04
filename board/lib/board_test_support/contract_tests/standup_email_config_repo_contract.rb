require "board/entities/standup_email_config"
require "board_test_support/contract_tests/entity_repo_contract"

def assert_works_like_a_standup_email_config_repo(repo_factory:)
  assert_works_like_an_entity_repo(
    generate_repo_lambda:  -> { repo_factory.standup_email_config_repo },
    entity_class:          Board::Entities::StandupEmailConfig,
  )

  describe "finding by whiteboard_id" do
    it "finds the first matching standup_email_config with the specified whiteboard_id" do
      first_config  = Board::Entities::StandupEmailConfig.new(whiteboard_id: whiteboard_id)
      second_config = Board::Entities::StandupEmailConfig.new(whiteboard_id: whiteboard_id)

      repo.save(first_config)
      repo.save(second_config)

      expect(repo.find_by_whiteboard_id(whiteboard_id)).to eq(first_config)
    end

    let(:whiteboard_id) { 1 }
    let(:repo)          { repo_factory.standup_email_config_repo }
  end
end

