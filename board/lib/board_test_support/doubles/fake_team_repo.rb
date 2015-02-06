require 'securerandom'

#note: this should be refactored
class FakeTeamRepo
  def initialize
    @teams = Hash.new
  end

  def save(team)
    team.id = SecureRandom.uuid
    @teams[team.id] = team
  end

  def find(id)
    @teams[id]
  end
end
