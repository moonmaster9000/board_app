class GuiSpy
  def validation_failed(errors)
    @spy_validation_errors = errors
  end
  attr_reader :spy_validation_errors

  def team_created(team)
    @spy_created_team = team
  end
  attr_reader :spy_created_team

  def help_created(help)
    @spy_created_help = help
  end
  attr_reader :spy_created_help

  def team_presented(team)
    @spy_presented_team = team
  end
  attr_reader :spy_presented_team

  def teams_presented(teams)
    @spy_presented_teams = teams
  end
  attr_reader :spy_presented_teams

  def new_face_created(new_face)
    @spy_created_new_face = new_face
  end
  attr_reader :spy_created_new_face

  def standup_presented(standup)
    @spy_presented_standup = standup
  end
  attr_reader :spy_presented_standup
end
