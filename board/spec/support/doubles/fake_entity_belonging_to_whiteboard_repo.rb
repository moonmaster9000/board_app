require "support/doubles/fake_entity_repo"

class FakeEntityBelongingToWhiteboardRepo < FakeEntityRepo
  def all_by_whiteboard_id_and_date(whiteboard_id, date)
    all_by_whiteboard_id(whiteboard_id).select do |entity|
      entity.date == date
    end
  end

  def unarchived_by_whiteboard_id_on_or_before_date(whiteboard_id, date)
    unarchived_by_whiteboard_id(whiteboard_id).select do |entity|
      entity.date <= date
    end
  end

  def unarchived_by_whiteboard_id(whiteboard_id)
    all_by_whiteboard_id(whiteboard_id).select { |e| !e.archived? }
  end

  def all_by_whiteboard_id(whiteboard_id)
    all.select do |entity|
      entity.whiteboard_id == whiteboard_id
    end
  end
end
