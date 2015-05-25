require "securerandom"

class FakeEntityRepo
  def initialize
    @entities = {}
  end

  def save(entity)
    entity.id = SecureRandom.uuid unless entity.id
    @entities[entity.id] = entity
  end

  def find(id)
    @entities[id]
  end

  def all
    @entities.values
  end
end
