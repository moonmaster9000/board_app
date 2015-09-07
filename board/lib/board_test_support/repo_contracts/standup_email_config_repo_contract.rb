require "board/use_cases/standups/entities/standup_email_config"
require "board_test_support/repo_contracts/entity_repo_contract"

def assert_works_like_a_standup_email_config_repo(repo_factory:)
  describe "setting the config" do
    it "persists the email config" do
      config = Board::Entities::StandupEmailConfig.new(whiteboard_id: whiteboard_id)

      repo.set(config)
      expect(repo.find_by_whiteboard_id(whiteboard_id)).to eq(config)
    end

    it "overwrites existing email configs" do
      old_config = Board::Entities::StandupEmailConfig.new(whiteboard_id: whiteboard_id, from_address: "old address")
      new_config = Board::Entities::StandupEmailConfig.new(whiteboard_id: whiteboard_id, from_address: "new address")

      repo.set(old_config)
      repo.set(new_config)

      expect(repo.find_by_whiteboard_id(whiteboard_id)).to eq(new_config)
    end

    it "returns nil when no matching standup_email_config is found" do
      expect(repo.find_by_whiteboard_id("nonexistant_whiteboard_id")).to be_nil
    end

    let(:whiteboard_id) { 1 }
    let(:repo) { repo_factory.standup_email_config_repo }
  end
end

