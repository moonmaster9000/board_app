class GuiSpy
  def validation_failed(errors)
    @spy_validation_errors = errors
  end
  attr_reader :spy_validation_errors

  def team_created(team)
    @spy_created_team = team
  end
  attr_reader :spy_created_team

  def team_presented(team)
    @spy_presented_team = team
  end
  attr_reader :spy_presented_team
end
