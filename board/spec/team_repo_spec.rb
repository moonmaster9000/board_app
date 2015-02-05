require "board/entities/team"
require "board_test_support/doubles/fake_team_repo"

describe "team repo" do
  describe "persisting a team" do
    it "should give it a unique id" do
      team = create_team
      team2 = create_team

      expect(team2.id).not_to eq(team.id)
    end

    it "allows a team to be fetched at a later" do
      team = create_team
      expect(team_repo.find(team.id)).to eq(team)
    end
  end

  let(:team_repo) { FakeTeamRepo.new }

  def create_team
    team = Board::Entities::Team.new
    team_repo.save(team)
  end
end
