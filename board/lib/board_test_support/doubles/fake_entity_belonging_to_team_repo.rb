require "board_test_support/doubles/fake_entity_repo"

class FakeEntityBelongingToTeamRepo < FakeEntityRepo
  def all_by_team_id_and_date(team_id, date)
    all.select do |entity|
      entity.team_id == team_id && entity.date == date
    end
  end
end
