require "board/entities/team"

def assert_works_like_a_team_repo(team_repo_generator)
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

    let(:team_repo) { team_repo_generator.call }

    def create_team
      team = Board::Entities::Team.new
      team_repo.save(team)
    end
  end
end
