require "board_test_support/doubles/fake_entity_repo"

class FakeEntityBelongingToTeamRepo < FakeEntityRepo
  def all_by_team_id_and_date(team_id, date)
    all_by_team_id(team_id).select do |entity|
      entity.date == date
    end
  end

  def unarchived_by_team_id_on_or_before_date(team_id, date)
    unarchived_by_team_id(team_id).select do |entity|
      entity.date <= date
    end
  end

  def unarchived_by_team_id(team_id)
    all_by_team_id(team_id).select do |entity|
      !entity.archived?
    end
  end

  def all_by_team_id(team_id)
    all.select do |entity|
      entity.team_id == team_id
    end
  end
end
