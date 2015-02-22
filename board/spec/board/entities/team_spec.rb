require "board/entities/team"

describe "team" do
  specify "it equals another team entity with the same id" do
    team1 = Board::Entities::Team.new id: "1"
    another_team1 = Board::Entities::Team.new id: "1"
    team2 = Board::Entities::Team.new id: "2"

    expect(team1).to eq(another_team1)
    expect(team1).not_to eq(team2)
  end
end
