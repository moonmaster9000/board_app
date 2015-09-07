def verify_whiteboard_entity_contract(entity_class:, generate_repo_lambda:)
  describe "Repo For Entities That Belong To Whiteboards" do
    context "Given entities for different whiteboards on varying dates" do
      before do
        entity_repo.save(whiteboard_1_archived_past_entity)
        entity_repo.save(whiteboard_1_unarchived_past_entity)
        entity_repo.save(whiteboard_1_today_entity)
        entity_repo.save(whiteboard_1_tomorrow_entity)
        entity_repo.save(whiteboard_2_entity)
      end

      it "should fetch those entities by whiteboard and date" do
        whiteboard_1_today_entities = entity_repo.all_by_whiteboard_id_and_date(whiteboard_1_id, today)

        expect(whiteboard_1_today_entities).to include whiteboard_1_today_entity
        expect(whiteboard_1_today_entities).not_to include whiteboard_1_tomorrow_entity
        expect(whiteboard_1_today_entities).not_to include whiteboard_2_entity
      end

      it "should fetch those entities by whiteboard" do
        whiteboard_1_entities = entity_repo.all_by_whiteboard_id(whiteboard_1_id)

        expect(whiteboard_1_entities).to include(whiteboard_1_today_entity, whiteboard_1_tomorrow_entity)
        expect(whiteboard_1_entities).not_to include(whiteboard_2_entity)
      end

      it "should fetch unarchived entities by whiteboard on or before a date" do
        unarchived_up_to_today = entity_repo.unarchived_by_whiteboard_id_on_or_before_date(whiteboard_1_id, today)

        expect(unarchived_up_to_today).to include(whiteboard_1_today_entity, whiteboard_1_unarchived_past_entity)
        expect(unarchived_up_to_today).not_to include(whiteboard_1_archived_past_entity)
      end
      
      it "should fetch unarchived entities by whiteboard" do
        whiteboard_1_unarchived_entities = entity_repo.unarchived_by_whiteboard_id(whiteboard_1_id)

        expect(whiteboard_1_unarchived_entities).to include(whiteboard_1_tomorrow_entity, whiteboard_1_today_entity, whiteboard_1_unarchived_past_entity)
        expect(whiteboard_1_unarchived_entities).not_to include(whiteboard_1_archived_past_entity)
      end
    end

    let(:whiteboard_1_archived_past_entity)   { entity_class.new(whiteboard_id: whiteboard_1_id, date: yesterday, archived: true) }
    let(:whiteboard_1_unarchived_past_entity) { entity_class.new(whiteboard_id: whiteboard_1_id, date: yesterday) }
    let(:whiteboard_1_today_entity)           { entity_class.new(whiteboard_id: whiteboard_1_id, date: today)     }
    let(:whiteboard_1_tomorrow_entity)        { entity_class.new(whiteboard_id: whiteboard_1_id, date: tomorrow)  }
    let(:whiteboard_2_entity)                 { entity_class.new(whiteboard_id: whiteboard_2_id, date: today)     }

    let(:entity_repo) { generate_repo_lambda.call }
    let(:yesterday) { today.prev_day }
    let(:today) { Date.today }
    let(:tomorrow) { today.next_day}
    let(:whiteboard_1_id) { 1 }
    let(:whiteboard_2_id) { 2 }
  end
end
