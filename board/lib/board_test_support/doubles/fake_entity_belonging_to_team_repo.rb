require "board_test_support/doubles/fake_entity_repo"

class FakeEntityBelongingToTeamRepo < FakeEntityRepo
  def all_by_team_id(team_id)
    all.select {|new_face| new_face.team_id == team_id }
  end
end
