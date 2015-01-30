require "board/entities/team"
require "board_test_support/doubles/fake_team_repo"

describe "team repo" do
  describe "persisting a team" do
    it "should give it a unique id" do
      team = Board::Entities::Team.new
      team_repo.save(team)

      expect(team.id).to be

      team2 = Board::Entities::Team.new
      team_repo.save(team2)

      expect(team2.id).not_to eq(team.id)
    end

    it "allows a team to be fetched at a later" do
      team = Board::Entities::Team.new
      team_repo.save(team)
      saved_team_id = team.id

      expect(team_repo.find(saved_team_id)).to eq(team)
    end
  end

  let(:team_repo) { FakeTeamRepo.new }
end
