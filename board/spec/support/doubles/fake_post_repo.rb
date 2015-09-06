require "support/doubles/fake_entity_repo"

class FakePostRepo < FakeEntityRepo
  def find_by_whiteboard_id_and_standup_date(whiteboard_id, standup_date)
    all.find { |p| p.standup_date == standup_date && p.whiteboard_id == whiteboard_id }
  end
end
