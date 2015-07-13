require "board_test_support/doubles/fake_entity_repo"

class FakeStandupEmailConfigRepo < FakeEntityRepo
  def find_by_whiteboard_id(whiteboard_id)
    all.find {|c| c.whiteboard_id == whiteboard_id }
  end

  def set(config)
    @entities.delete_if { |id, c| c.whiteboard_id == config.whiteboard_id }
    save(config)
  end
end
